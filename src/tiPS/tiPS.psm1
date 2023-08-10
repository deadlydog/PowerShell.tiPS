# Classes must be imported with the 'using module' statement, which has to be the first line of the script.
using module .\Classes\Tip.ps1

#Requires -Version 5.0
Set-StrictMode -Version Latest

# Import all of the functions from the Private and Public folders.
[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter '*.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter '*.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilesToImport = $privateFunctionFilePaths + $publicFunctionFilePaths

$functionFilesToImport | ForEach-Object {
	[string] $filePath = $_

	try
	{
		Write-Debug "Dot-source importing function from file '$filePath'."
		. $_
	}
	catch
	{
		Write-Error "Failed to import function from file '$filePath': $_"
	}
}

# Function and Alias exports are defined in the modules manifest (.psd1) file.
