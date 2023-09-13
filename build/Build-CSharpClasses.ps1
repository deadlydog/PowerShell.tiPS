# This script builds the CSharp Classes DLL file and places it in the Classes directory of the module.

[CmdletBinding()]
Param()

[string] $repositoryRoot = Split-Path $PSScriptRoot -Parent -Resolve
[string] $moduleDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/tiPS'
[string] $moduleClassesDirectoryPath = Join-Path -Path $moduleDirectoryPath -ChildPath 'Classes'
[string] $csharpSolutionDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/CSharpClasses'
[string] $csharpSlnFilePath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses.sln'
[string] $csharpClassesDllDirectoryPath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses/bin/Release/netstandard2.0'

Write-Output "Deleting the DLL files in '$moduleClassesDirectoryPath' before rebuilding and replacing them."
Remove-Item -Path "$moduleClassesDirectoryPath/*" -Include '*.dll' -Force

Write-Output "Building C# sln '$csharpSlnFilePath' in Release mode."
& dotnet.exe build "$csharpSlnFilePath" --configuration Release

Write-Output "Copying the DLL files in '$csharpClassesDllDirectoryPath' to the module's Classes directory '$moduleClassesDirectoryPath'."
Copy-Item -Path "$csharpClassesDllDirectoryPath/*" -Destination $moduleClassesDirectoryPath -Include '*.dll' -Force
