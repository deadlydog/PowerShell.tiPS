# This file is generated and overwritten in the CI/CD pipeline by the build script /build/Build-Psm1File.ps1.
# Any changes made to this file should be reflected in that script, otherwise they will not be present
# in the module built and deployed by the CI/CD pipeline.

#Requires -Version 3.0
Set-StrictMode -Version Latest

# All module functions that reference a file path in the module should use this variable, rather than PSScriptRoot.
New-Variable -Name 'PSModuleRoot' -Value $PSScriptRoot -Option Constant -Scope Script

# Import all Classes and Private and Public functions from their respective directories, in that order.
[string[]] $classFilePaths =
	Get-ChildItem -Path $PSScriptRoot/Classes -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot/Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot/Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilePathsToImport = $classFilePaths + $privateFunctionFilePaths + $publicFunctionFilePaths

foreach ($filePath in $functionFilePathsToImport)
{
	try
	{
		Write-Debug "Dot-source importing functions/types from file '$filePath'."
		. $filePath
	}
	catch
	{
		Write-Error "Failed to dot-source import functions/types from file '$filePath': $_"
	}
}

Write-Debug 'Now that all types and functions are imported, initializing the module.'
InitializeModule

# Function and Alias exports are defined in the modules manifest (.psd1) file.
