# 001 - Use PowerShell instead of C\#

## Status

Accepted 2023-07-16

## Context

Both C# and PowerShell can be used to create PowerShell modules.
We need to decide which language to use for this module.

C# is a type-safe, compiled language, which makes it compelling to use since many problems can be caught at compile time instead of runtime.
Most of the native PowerShell cmdlets are written in C#, as strongly typed code is easier to maintain and debug.

PowerShell is a dynamic language.
While it does have some type safety, it is not as strict as C#.
PSScripAnalyzer is able to catch some problems at edit-time, but because there is no actual compiler, many types of errors can not be found until runtime, requiring more tests and leading to more bugs.

This module is designed to be used by other PowerShell developers, and hopefully will have many contributors.

## Decision

This module will be written in PowerShell.

While C# may be better suited for large projects and projects where preventing regressions is critical, this module is small and will be used by other PowerShell developers.
Many PowerShell developers are not familiar with C#, and may not be able to contribute to the project if it is written in C#.
In order to keep the barrier-to-entry for contributions as low as possible, this module will be written in PowerShell.

## Consequences

- Additional tests will be required to ensure that the module is working as expected.
