function RemoveTipsAlreadySeen
{
	[CmdletBinding()]
	[OutputType([System.Collections.Specialized.OrderedDictionary])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The hashtable of tips to remove tips that have already been seen from.')]
		[hashtable] $Tips
	)

	[string[]] $tipIdsAlreadySeen = ReadTipIdsAlreadySeenOrDefault
	if ($null -ne $tipIdsAlreadySeen -and $tipIdsAlreadySeen.Count -gt 0)
	{
		Write-Verbose "Removing $($tipIdsAlreadySeen.Count) tips that have already been seen."
		foreach ($tipId in $tipIdsAlreadySeen)
		{
			$Tips.Remove($tipId)
		}
	}
}

function ReadTipIdsAlreadySeenOrDefault
{
	[CmdletBinding()]
	[OutputType([string[]])]
	Param()

	[string[]] $tipIdsAlreadySeen = @()
	[string] $tipIdsAlreadySeenFilePath = GetTipIdsAlreadySeenFilePath
	if (Test-Path -Path $tipIdsAlreadySeenFilePath -PathType Leaf)
	{
		$tipIdsAlreadySeen = [System.IO.File]::ReadAllLines($tipIdsAlreadySeenFilePath)
	}
	return $tipIdsAlreadySeen
}

function AppendTipIdToTipIdsAlreadySeen
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[string] $TipId
	)

	[string] $tipIdsAlreadySeenFilePath = GetTipIdsAlreadySeenFilePath
	Write-Verbose "Appending Tip ID '$TipId' to '$tipIdsAlreadySeenFilePath'."
	[System.IO.File]::AppendAllLines($tipIdsAlreadySeenFilePath, $TipId)
}

function ClearTipIdsAlreadySeen
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	[string] $tipIdsAlreadySeenFilePath = GetTipIdsAlreadySeenFilePath
	Write-Verbose "Clearing '$tipIdsAlreadySeenFilePath'."
	[System.IO.File]::WriteAllText($tipIdsAlreadySeenFilePath, [string]::Empty)
}

function GetTipIdsAlreadySeenFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $tipIdsAlreadySeenFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'TipIdsAlreadySeen.txt'
	return $tipIdsAlreadySeenFilePath
}
