# This script builds the C# DLL files and places them in the Classes directory of the module.

[CmdletBinding()]
Param
(
	[Parameter(Mandatory = $false, HelpMessage = 'The version number to build the assemblies with, in the format "Major.Minor.Build.Revision". Default is "1.0.0.0".')]
	[string] $VersionNumber = '1.0.0.0',

	[Parameter(Mandatory = $false, HelpMessage = 'If specified, the module DLL files will be rebuilt even if they already exist. Otherwise, they will only be built if they do not exist.')]
	[switch] $Force
)

[string] $repositoryRoot = Split-Path $PSScriptRoot -Parent -Resolve
[string] $moduleDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/tiPS'
[string] $moduleClassesDirectoryPath = Join-Path -Path $moduleDirectoryPath -ChildPath 'Classes'
[string] $csharpSolutionDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/CSharpClasses'
[string] $csharpSlnFilePath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses.sln'
[string] $csharpClassesDllDirectoryPath = Join-Path -Path $csharpSolutionDirectoryPath -ChildPath 'tiPSClasses/bin/Release/netstandard2.0'

[bool] $assembliesAreAlreadyBuilt = (Test-Path -Path $moduleClassesDirectoryPath/*.dll -PathType Leaf)
if ($assembliesAreAlreadyBuilt -and -not $Force)
{
	Write-Verbose "The tiPS C# assemblies are already built. Skipping the build."
	return
}

Write-Output "Deleting the DLL files in '$moduleClassesDirectoryPath' before rebuilding and replacing them."
Remove-Item -Path "$moduleClassesDirectoryPath/*" -Include '*.dll' -Force -ErrorVariable removeDllFilesError

if ($removeDllFilesError)
{
	throw "Error deleting the DLL files in '$moduleClassesDirectoryPath'. They are likely in use by another process that imported tiPS. Try closing all PowerShell sessions and running the script again. Error: $removeDllFilesError"
}

Write-Output "Building C# sln '$csharpSlnFilePath' in Release mode with version number '$VersionNumber'."
& dotnet build "$csharpSlnFilePath" --configuration Release -p:Version=$VersionNumber

Write-Output "Copying the DLL files in '$csharpClassesDllDirectoryPath' to the module's Classes directory '$moduleClassesDirectoryPath'."
Copy-Item -Path "$csharpClassesDllDirectoryPath/*" -Destination $moduleClassesDirectoryPath -Include '*.dll' -Force
