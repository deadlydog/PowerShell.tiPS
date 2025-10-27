# This is a helper script to build the tiPS C# assemblies if needed and then import the module.

[string] $buildScriptPath = Resolve-Path -Path "$PSScriptRoot/../../build/Build-CSharpAssemblies.ps1"
[string] $moduleDirectoryPath = Resolve-Path -Path "$PSScriptRoot/../../src/tiPS"

& $buildScriptPath

Import-Module $moduleDirectoryPath -Force
