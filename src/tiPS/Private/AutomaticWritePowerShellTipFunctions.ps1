function WriteAutomaticPowerShellTipIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[tiPS.Configuration] $Config
	)

	[DateTime] $lastAutomaticTipWrittenDate = ReadLastAutomaticTipWrittenDateOrDefault
	[TimeSpan] $timeSinceLastAutomaticTipWritten = [DateTime]::Now - $lastAutomaticTipWrittenDate
	[int] $daysSinceLastAutomaticTipWritten = $timeSinceLastAutomaticTipWritten.Days

	[bool] $shouldShowTip = $false
	switch ($Config.AutoWritePowerShellTipCadence)
	{
		([tiPS.WritePowerShellTipCadence]::Never) { $shouldShowTip = $false; break }
		([tiPS.WritePowerShellTipCadence]::EveryStartup) { $shouldShowTip = $true; break }
		([tiPS.WritePowerShellTipCadence]::Daily) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 1; break }
		([tiPS.WritePowerShellTipCadence]::Weekly) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 7; break }
	}

	if ($shouldShowTip)
	{
		WriteAutomaticPowerShellTip
	}
	else
	{
		Write-Debug "Showing a tiPS PowerShell tip is not needed at this time."
	}
}

function WriteAutomaticPowerShellTip
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-PowerShellTip

	[DateTime] $todayWithoutTime = [DateTime]::Now.Date # Exclude the time for a better user experience.
	WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate $todayWithoutTime
}

function ReadLastAutomaticTipWrittenDateOrDefault
{
	[CmdletBinding()]
	[OutputType([DateTime])]
	Param()

	[DateTime] $lastAutomaticTipWrittenDate = [DateTime]::MinValue
	[string] $lastAutomaticTipWrittenDateFilePath = GetLastAutomaticTipWrittenDateFilePath
	if (Test-Path -Path $lastAutomaticTipWrittenDateFilePath -PathType Leaf)
	{
		[string] $lastAutomaticTipWrittenDateString = Get-Content -Path $lastAutomaticTipWrittenDateFilePath -Raw
		$lastAutomaticTipWrittenDate = [DateTime]::Parse($lastAutomaticTipWrittenDateString)
	}
	return $lastAutomaticTipWrittenDate
}

function WriteLastAutomaticTipWrittenDate
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[DateTime] $LastAutomaticTipWrittenDate
	)

	[string] $lastAutomaticTipWrittenDateFilePath = GetLastAutomaticTipWrittenDateFilePath
	Write-Verbose "Writing last automatic tip Written date '$LastAutomaticTipWrittenDate' to '$lastAutomaticTipWrittenDateFilePath'."
	$LastAutomaticTipWrittenDate.ToString() | Set-Content -Path $lastAutomaticTipWrittenDateFilePath -Force -NoNewline
}

function GetLastAutomaticTipWrittenDateFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $lastAutomaticTipWrittenDateFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'LastAutomaticTipWrittenDate.txt'
	return $lastAutomaticTipWrittenDateFilePath
}
