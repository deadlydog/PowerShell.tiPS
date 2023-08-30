# Use C# classes and enums as they provide a better dev and module consumer experience:
# 	https://blog.danskingdom.com/How-and-where-to-properly-define-classes-and-enums-in-your-PowerShell-modules/
# Store the actual code in a .cs file to get syntax checking and IntelliSense, and just read it in and load it here.
[string] $classDefinition = Get-Content -Path "$PSScriptRoot\Configuration.cs" -Raw
Add-Type -Language CSharp -TypeDefinition $classDefinition
