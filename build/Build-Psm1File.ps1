# This script is used in the CI/CD pipeline to generate and overwrite the tiPS.psm1 file.
# Rather than having to dot-source all of the files into the module, this script will concatenate
# all of the files into a single file. Dot-sourcing files at runtime is expensive and increases
# the load time of the module, so we want to avoid it. For more info, see
# docs/ArchitectureDecisionRecords/005-How-to-dot-source-files-into-the-module-psm1-file.md.

[CmdletBinding()]
Param
(
	[Parameter(Mandatory = $false, HelpMessage = 'If provided, the source files will be deleted after importing their contents into the generated psm1 module file.')]
	[switch] $DeleteSourceFilesAfterImport
)

[string] $repositoryRoot = Split-Path $PSScriptRoot -Parent -Resolve
[string] $moduleDirectoryPath = Join-Path -Path $repositoryRoot -ChildPath 'src/tiPS'

# Import all Classes and Private and Public functions from their respective directories, in that order.
[string[]] $classFilePaths =
	Get-ChildItem -Path $moduleDirectoryPath/Classes -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $moduleDirectoryPath/Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $moduleDirectoryPath/Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilePathsToImport = $classFilePaths + $privateFunctionFilePaths + $publicFunctionFilePaths

[string] $importedFileContents = [string]::Empty
foreach ($filePath in $functionFilePathsToImport)
{
	try
	{
		Write-Verbose "Appending functions/types from file '$filePath'."
		[string] $fileContents = Get-Content -Path $filePath -Raw
		$importedFileContents += $fileContents.Trim() + ([System.Environment]::NewLine * 2)
	}
	catch
	{
		Write-Error "Failed to read and append functions/types from file '$filePath': $_"
	}
}

if ($DeleteSourceFilesAfterImport)
{
	Write-Verbose "Deleting source files from '$moduleDirectoryPath'."
	Remove-Item -Path $functionFilePathsToImport -Force
}

[string] $moduleFilePath = Join-Path -Path $moduleDirectoryPath -ChildPath 'tiPS.psm1'
[string] $moduleFileContents = @"
#Requires -Version 3.0
Set-StrictMode -Version Latest

# All module functions that reference a file path in the module should use this variable, rather than PSScriptRoot.
New-Variable -Name 'PSModuleRoot' -Value `$PSScriptRoot -Option Constant -Scope Script

$importedFileContents

Write-Debug 'Now that all types and functions are imported, initializing the module.'
InitializeModule

# Function and Alias exports are defined in the modules manifest (.psd1) file.
"@

Write-Verbose "Writing module file to '$moduleFilePath'."
Set-Content -Path $moduleFilePath -Value $moduleFileContents -Encoding UTF8 -Force

Write-Output "Completed generating module file '$moduleFilePath' from '$($functionFilePathsToImport.Length)' other files."
