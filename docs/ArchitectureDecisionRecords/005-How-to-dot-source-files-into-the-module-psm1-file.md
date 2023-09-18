# 005 - How to dot-source files into the module psm1 file

## Status

Accepted 2023-09-12
Decision changed and ADR updated 2023-09-15

## Context

After adding `Import-Module -Name tiPS` to my PowerShell profile, we noticed that it took noticeably longer to load my profile; more than 1 second.
After some investigation [with Profiler](https://blog.danskingdom.com/Easily-profile-your-PowerShell-code-with-the-Profiler-module/) We found that the bulk of the time was spent dot-sourcing the files into the module.
The alternative is to define all of the module functions directly in the .psm1 file, but having a single large file with all of the module's code in it is not ideal for organization and maintainability.
We decided to do some performance comparisons of the different ways to define the functions in the module.

One of the main benefits of the tiPS module is automatically showing tips at the start of a PowerShell session, so we want to keep the startup time as fast as possible so users are not hesitant to import the module in their PowerShell profile.

### Comparison of different ways to define functions in the module

We tried defining the functions directly in the .psm1 file, as well as 4 different ways to import the functions into the module.
When the tests were performed, there were 15 different files being imported into the module.
we recorded the average time to load the module using each method:

1. (1060ms) Define all of the code directly in the .psm1 file.
1. (1180ms) Dot-source each file individually in the .psm1 file: `. $filePath`
1. (1150ms) Use `Invoke-Expression` with `Get-Content`: `Invoke-Expression -Command (Get-Content -Path $filePath -Raw)`
1. (1120ms) Use `Invoke-Expression` with `[System.IO.File]::ReadAllText`: `Invoke-Expression -Command ([System.IO.File]::ReadAllText($filePath))`
1. (1140ms) Use `$ExecutionContext.InvokeCommand.InvokeScript`:

    ```powershell
    $ExecutionContext.InvokeCommand.InvokeScript(
      $false,
      ([scriptblock]::Create([System.IO.File]::ReadAllText($filePath, [Text.Encoding]::UTF8))),
      $null, $null)
    ```

It is also worth noting that only the first two options of either defining the code directly in the .psm1 file or dot-sourcing the files individually allowed us to still put breakpoints in VS Code and have the debugger stop at them.
When using the `Invoke-Expression` or `$ExecutionContext.InvokeCommand.InvokeScript` methods, the debugger would not stop at breakpoints in the imported files.

Our original assumption that the act of dot-sourcing the files was the cause of the slow startup time was incorrect.
All of the methods tested took roughly the same amount of time to load the module, so the slow startup bottleneck lies somewhere else.
Spoiler: We found it is when importing the C# classes.

## Decision

Defining the functions directly in the .psm1 file is the fastest, but it's not a good option for maintainability.
To try and get the best of both worlds, we created a [/build/Build-Psm1File.ps1](/build/Build-Psm1File.ps1) script that allows us to define the functions in separate files and then generate the .psm1 file with all of the functions defined in it.

For development, we are going to stick with dot-sourcing the files individually in the .psm1 file.
This provides the best developer experience in terms of code organization, and still allows us to use breakpoints in VS Code.

In the CI/CD pipeline, at build time we will use the [/build/Build-Psm1File.ps1](/build/Build-Psm1File.ps1) script to generate the concatenated .psm1 file with all of the functions defined directly in it.
This will allow the published module to have the fastest startup time possible.

At this time, the performance difference between dot-sourcing and defining the code directly in the .psm1 file is ~120ms.
As more functions are added to the module, this difference would increase.
By generating the psm1 file at build time, we are ensuring that the startup time of the module will not increase as more functions are added.

## Consequences

While this decision accomplishes the goal of a faster startup time, it also introduces additional complexity.

- The psm1 file in source control will need to be kept in sync with the [/build/Build-Psm1File.ps1](/build/Build-Psm1File.ps1) script.
- The published module will have a different file structure and psm1 file than what is in source control, which could cause confusion and potential bugs down the road.

We are sacrificing some simplicity and maintainability for startup time performance.
