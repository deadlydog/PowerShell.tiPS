# This script builds the C# DLL files and places them in the Classes directory of the module.

[CmdletBinding()]
Param()

[string] $repositoryRoot = Split-Path $PSScriptRoot -Parent -Resolve
[string] $moduleDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/tiPS'
[string] $moduleClassesDirectoryPath = Join-Path -Path $moduleDirectoryPath -ChildPath 'Classes'
[string] $csharpSolutionDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/CSharpClasses'
[string] $csharpSlnFilePath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses.sln'
[string] $csharpClassesDllDirectoryPath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses/bin/Release/netstandard2.0'

Write-Output "Deleting the DLL files in '$moduleClassesDirectoryPath' before rebuilding and replacing them."
Remove-Item -Path "$moduleClassesDirectoryPath/*" -Include '*.dll' -Force -ErrorVariable removeDllFilesError

if ($removeDllFilesError)
{
	throw "Error deleting the DLL files in '$moduleClassesDirectoryPath'. They are likely in use by another process that imported tiPS. You can try closing all PowerShell sessions and trying again. Error: $removeDllFilesError"
}

Write-Output "Building C# sln '$csharpSlnFilePath' in Release mode."
& dotnet.exe build "$csharpSlnFilePath" --configuration Release

Write-Output "Copying the DLL files in '$csharpClassesDllDirectoryPath' to the module's Classes directory '$moduleClassesDirectoryPath'."
Copy-Item -Path "$csharpClassesDllDirectoryPath/*" -Destination $moduleClassesDirectoryPath -Include '*.dll' -Force
