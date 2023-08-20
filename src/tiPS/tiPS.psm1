#Requires -Version 5.0
Set-StrictMode -Version Latest

# In order for classes and enums to be accessible outside of the module, they must be defined directly in the psm1 file.
# For more info see: https://github.com/deadlydog/PowerShell.Experiment.ClassInModule

# Import all Private and Public functions from their respective directories.
[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilesToImport = $privateFunctionFilePaths + $publicFunctionFilePaths

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

Write-Debug 'Now that all types and functions are imported, initializing the module by reading in all the PowerShell tips.'
LoadAllPowerShellTipsFromJsonFile

# Function and Alias exports are defined in the modules manifest (.psd1) file.
