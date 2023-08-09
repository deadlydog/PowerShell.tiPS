using module .\Classes\Tip.ps1

#Requires -Version 5.0
Set-StrictMode -Version Latest

[hashtable] $Tips = @{}

function Get-PowerShellTip
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId
	)

	if ([string]::IsNullOrWhiteSpace($TipId))
	{
		$TipId = $Tips.Keys | Get-Random -Count 1
	}

	[Tip] $tip = $Tips[$TipId]
	return $tip
}

function Write-PowerShellTip
{
	[CmdletBinding()]
	[Alias('Write-PSTip', 'Write-Tip', 'Tips')]
	Param
	(
		[Parameter(Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId
	)

	[string] $tip = Get-PowerShellTip -TipId $TipId
	Write-Host -Object $tip
}

function GetTipsDirectoryPath
{
	[string] $thisScriptsDirectoryPath = $PSScriptRoot
	[string] $tipsDirectoryPath = Join-Path -Path $thisScriptsDirectoryPath -ChildPath 'PowerShellTips'
	return $tipsDirectoryPath
}

function GetRandomTipFilePath
{
	Param
	(
		[Parameter(Mandatory = $true)]
		[string] $tipsDirectoryPath
	)

	[string] $tipFilePath = Get-ChildItem -Path $tipsDirectoryPath -Filter '*.ps1' |
		Get-Random -Count 1 |
		Select-Object -ExpandProperty FullName
	return $tipFilePath
}

# TODO: Move this tip aggregation into a build-time operation and dot-source just the one file at runtime.
function InitializeModule
{
	[string] $tipsDirectoryPath = GetTipsDirectoryPath
	[string[]] $tipFilePaths =
		Get-ChildItem -Path $tipsDirectoryPath -Filter '*.ps1' -Recurse |
		Select-Object -ExpandProperty FullName

	foreach ($tipFilePath in $tipFilePaths)
	{
		# Dot-source the tip file, which should have a $tip variable defined with all of the tip info.
		. $tipFilePath

		$tip.Validate()
		$Tips.Add($tip.Id, $tip)
	}
}
InitializeModule

# Function and Alias exports are defined in the modules manifest (.psd1) file.
