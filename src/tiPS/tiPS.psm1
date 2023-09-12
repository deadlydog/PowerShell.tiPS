#Requires -Version 3.0
Set-StrictMode -Version Latest

New-Variable -Name 'PSModuleRoot' -Value $PSScriptRoot -Option Constant -Scope Script

# Import all Classes and Private and Public functions from their respective directories, in that order.
[string[]] $classFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Classes -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilePathsToImport = $classFilePaths + $privateFunctionFilePaths + $publicFunctionFilePaths

foreach ($filePath in $functionFilePathsToImport)
{
	try
	{
		Write-Debug "Dot-source importing functions/types from file '$filePath'."
		. $filePath # 1180ms
		# Invoke-Expression -Command (Get-Content -Path $filePath -Raw) # 1150ms
		# Invoke-Expression -Command ([System.IO.File]::ReadAllText($filePath)) # 1120ms
		# $ExecutionContext.InvokeCommand.InvokeScript( # 1140ms
		# 	$false,
		# 	(
		# 		[scriptblock]::Create(
		# 			[io.file]::ReadAllText(
		# 				$filePath,
		# 				[Text.Encoding]::UTF8
		# 			)
		# 		)
		# 	), $null, $null
		# )
	}
	catch
	{
		Write-Error "Failed to dot-source import functions/types from file '$filePath': $_"
	}
}

Write-Debug 'Now that all types and functions are imported, initializing the module.'
InitializeModule

# Function and Alias exports are defined in the modules manifest (.psd1) file.
