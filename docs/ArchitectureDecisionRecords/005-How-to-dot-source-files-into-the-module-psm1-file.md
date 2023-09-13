# 005 - How to dot-source files into the module psm1 file

## Status

Accepted 2023-09-12

## Context

After adding `Import-Module -Name tiPS` to my PowerShell profile, we noticed that it took noticeably longer to load my profile; more than 1 second.
After some investigation [with Profiler](https://blog.danskingdom.com/Easily-profile-your-PowerShell-code-with-the-Profiler-module/) We found that the bulk of the time was spent dot-sourcing the files into the module.
The alternative is to define all of the module functions directly in the .psm1 file, but having a single large file with all of the module's code in it is not ideal for organization and maintainability.
We decided to do some performance comparisons of the different ways to define the functions in the module.

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

While defining the functions directly in the .psm1 file is the fastest, it's not a good option for maintainability.
To try and get the best of both worlds, we created a `build/Generate-Psm1File.ps1` script that allows us to define the functions in separate files and then generate the .psm1 file with all of the functions defined in it.
While this does accomplish the goal, it introduces additional complexity and a new script that needs to be maintained.

For now I'm going to stick with dot-sourcing the files individually in the .psm1 file.
This is the simplest option and still allows us to use breakpoints in VS Code.
Also, the performance difference between the different methods with the current number of files is low.
If the dot-sourcing time becomes a problem as more files are added to the module, we can revisit this decision.

## Consequences

We are sacrificing a tiny bit of startup time for maintainability and simplicity.
As more files are added to the module, we may need to revisit this decision if the performance tradeoff becomes greater.
