# Include the enum type the class depends on.
# . "$PSScriptRoot\..\Enums\PowerShellTipTag.ps1"

# Use C# classes and enums as they provide a better dev and module consumer experience.
# https://blog.danskingdom.com/How-and-where-to-properly-define-classes-and-enums-in-your-PowerShell-modules/
[string] $classDefinition = Get-Content -Path "$PSScriptRoot\PowerShellTip.cs" -Raw
Add-Type -Language CSharp -TypeDefinition $classDefinition
