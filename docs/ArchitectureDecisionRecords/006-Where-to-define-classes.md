# 006 - Where to define classes

## Status

Accepted 2023-09-13

## Context

In the previous ADR we initially thought that it was the dot-sourcing of the files that was causing the slow startup time, but after further investigation we found that most of the time was spent in the `Add-Type -Language CSharp -TypeDefinition $classDefinition` lines to import the Configuration and PowerShellTip C# classes.
Basically about 1 full second is spent just importing the 2 classes and their associated enums into PowerShell.

We want to use classes because they provide strong typing and make it easier to work with the data.
We originally chose using C# classes over PowerShell classes due to [the limitations that PowerShell classes have](https://blog.danskingdom.com/How-and-where-to-properly-define-classes-and-enums-in-your-PowerShell-modules/); mainly they must be defined directly in the .psm1 file and users must use `using module` to import the module if they want to reference the classes in their own code.

We want to compare the performance of the different options for using classes in PowerShell modules to try and speed up our module load time.

### Class options comparison

The 3 different methods we want to compare, along with their caveats, are:

1. Using PowerShell classes defined in the .psm1 file.
   - PowerShell classes were introduced in PowerShell 5.0, so we can't use them if we want to support PowerShell 3.0 and 4.0.
1. Importing the C# classes from a .cs file using `Add-Type`.
   - [Windows PowerShell only supports C# 5.0](https://stackoverflow.com/a/40789694/602585), so we can't use any newer language features.
   See [the list of C# versions and their features](https://learn.microsoft.com/en-us/dotnet/csharp/whats-new/csharp-version-history).
1. Importing the C# classes from an assembly using `Add-Type`.
   - This means having to compile the C# classes into an assembly, which is an extra step that users will have to do if they want to modify the classes.
   - The assembly must be compiled against .NET Standard 2.0 so that it can be used in both Windows PowerShell and PowerShell Core.
   This means [it supports C# v7.3](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/configure-language-version).

The average time it takes to load the module with each of these methods is:

1. PowerShell classes: 375ms
1. C# classes from .cs file: 1250ms
1. C# classes from assembly: 270ms

## Decision

We are going to compile the C# classes into an assembly and import them using `Add-Type`.
This produces the fastest load time for the module, and allows us to use some of the newer C# features, while still supporting PowerShell all the way back to version 3.0.

## Consequences

The main consequence of this decision is that the C# classes need to be recompiled into a new assembly file when they are modified.
Building the C# assembly will need to be done by users during development, as well as part of the CI build process.
