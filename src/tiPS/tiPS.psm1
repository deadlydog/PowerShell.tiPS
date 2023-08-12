#Requires -Version 5.0
Set-StrictMode -Version Latest

# Import all of the Classes, Enums, and Private and Public functions from their respective directories.
[string[]] $classFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Classes -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilesToImport = $classFilePaths + $privateFunctionFilePaths + $publicFunctionFilePaths

$functionFilesToImport | ForEach-Object {
	[string] $filePath = $_

	try
	{
		Write-Debug "Dot-source importing functions/types from file '$filePath'."
		. $_
	}
	catch
	{
		Write-Error "Failed to dot-source import functions/types from file '$filePath': $_"
	}
}

# Function and Alias exports are defined in the modules manifest (.psd1) file.
