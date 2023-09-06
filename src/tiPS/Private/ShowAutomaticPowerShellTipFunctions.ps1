function ShowAutomaticPowerShellTipIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[tiPS.Configuration] $Config
	)

	[DateTime] $lastAutomaticTipShownDate = ReadLastAutomaticTipShownDateOrDefault
	[TimeSpan] $timeSinceLastAutomaticTipShown = [DateTime]::Now - $lastAutomaticTipShownDate
	[int] $daysSinceLastAutomaticTipShown = $timeSinceLastAutomaticTipShown.Days

	[bool] $shouldShowTip = $false
	switch ($Config.AutoShowPowerShellTipCadence)
	{
		([tiPS.ShowPowerShellTipCadence]::Never) { $shouldShowTip = $false; break }
		([tiPS.ShowPowerShellTipCadence]::EveryStartup) { $shouldShowTip = $true; break }
		([tiPS.ShowPowerShellTipCadence]::Daily) { $shouldShowTip = $daysSinceLastAutomaticTipShown -ge 1; break }
		([tiPS.ShowPowerShellTipCadence]::Weekly) { $shouldShowTip = $daysSinceLastAutomaticTipShown -ge 7; break }
	}

	if ($shouldShowTip)
	{
		ShowAutomaticPowerShellTip
	}
	else
	{
		Write-Debug "Showing a tiPS PowerShell tip is not needed at this time."
	}
}

function ShowAutomaticPowerShellTip
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-PowerShellTip

	[DateTime] $todayWithoutTime = [DateTime]::Now.Date # Exclude the time for a better user experience.
	WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate $todayWithoutTime
}

function ReadLastAutomaticTipShownDateOrDefault
{
	[CmdletBinding()]
	[OutputType([DateTime])]
	Param()

	[DateTime] $lastAutomaticTipShownDate = [DateTime]::MinValue
	[string] $lastAutomaticTipShownDateFilePath = GetLastAutomaticTipShownDateFilePath
	if (Test-Path -Path $lastAutomaticTipShownDateFilePath -PathType Leaf)
	{
		[string] $lastAutomaticTipShownDateString = Get-Content -Path $lastAutomaticTipShownDateFilePath -Raw
		$lastAutomaticTipShownDate = [DateTime]::Parse($lastAutomaticTipShownDateString)
	}
	return $lastAutomaticTipShownDate
}

function WriteLastAutomaticTipShownDate
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[DateTime] $LastAutomaticTipShownDate
	)

	[string] $lastAutomaticTipShownDateFilePath = GetLastAutomaticTipShownDateFilePath
	Write-Verbose "Writing last automatic tip shown date '$LastAutomaticTipShownDate' to '$lastAutomaticTipShownDateFilePath'."
	$LastAutomaticTipShownDate.ToString() | Set-Content -Path $lastAutomaticTipShownDateFilePath -Force -NoNewline
}

function GetLastAutomaticTipShownDateFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $lastAutomaticTipShownDateFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'LastAutomaticTipShownDate.txt'
	return $lastAutomaticTipShownDateFilePath
}
