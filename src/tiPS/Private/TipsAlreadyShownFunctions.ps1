function RemoveTipsAlreadyShown
{
	[CmdletBinding()]
	[OutputType([System.Collections.Specialized.OrderedDictionary])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The hashtable of tips to remove tips that have already been shown from.')]
		[hashtable] $Tips
	)

	[string[]] $tipIdsAlreadyShown = ReadTipIdsAlreadyShownOrDefault
	if ($tipIdsAlreadyShown.Count -gt 0)
	{
		Write-Verbose "Removing $($tipIdsAlreadyShown.Count) tips that have already been shown."
		foreach ($tipId in $tipIdsAlreadyShown)
		{
			$Tips.Remove($tipId)
		}
	}
}

function ReadTipIdsAlreadyShownOrDefault
{
	[CmdletBinding()]
	[OutputType([string[]])]
	# PSScriptAnalyzer does not properly handle the OutputType attribute for string arrays, so just
	# suppress the warning: https://github.com/PowerShell/PSScriptAnalyzer/issues/1471#issuecomment-1735962402
	[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseOutputTypeCorrectly', '')]
	Param()

	[string[]] $tipIdsAlreadyShown = @()
	[string] $tipIdsAlreadyShownFilePath = GetTipIdsAlreadyShownFilePath
	if (Test-Path -Path $tipIdsAlreadyShownFilePath -PathType Leaf)
	{
		$tipIdsAlreadyShown = [System.IO.File]::ReadAllLines($tipIdsAlreadyShownFilePath)
	}

	return ,$tipIdsAlreadyShown
}

function AppendTipIdToTipIdsAlreadyShown
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[string] $TipId
	)

	[string] $tipIdsAlreadyShownFilePath = GetTipIdsAlreadyShownFilePath
	[string[]] $tipIdAsArray = @($TipId)
	Write-Verbose "Appending Tip ID '$TipId' to '$tipIdsAlreadyShownFilePath'."
	[System.IO.File]::AppendAllLines($tipIdsAlreadyShownFilePath, $tipIdAsArray)
}

function ClearTipIdsAlreadyShown
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	[string] $tipIdsAlreadyShownFilePath = GetTipIdsAlreadyShownFilePath
	Write-Verbose "Clearing '$tipIdsAlreadyShownFilePath'."
	[System.IO.File]::WriteAllText($tipIdsAlreadyShownFilePath, [string]::Empty)
}

function GetTipIdsAlreadyShownFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $tipIdsAlreadyShownFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'TipIdsAlreadyShown.txt'
	return $tipIdsAlreadyShownFilePath
}
