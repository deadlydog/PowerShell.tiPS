function WriteAutomaticPowerShellTipIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The tiPS configuration used to determine if a tip should be written.')]
		[ValidateNotNullOrEmpty()]
		[tiPS.Configuration] $Config
	)

	# For performance reasons, check if we should never write a tip before doing anything else.
	if ($Config.AutoWritePowerShellTipCadence -eq [tiPS.WritePowerShellTipCadence]::Never)
	{
		return
	}

	[DateTime] $lastAutomaticTipWrittenDate = ReadLastAutomaticTipWrittenDateOrDefault
	[TimeSpan] $timeSinceLastAutomaticTipWritten = [DateTime]::Now - $lastAutomaticTipWrittenDate
	[int] $daysSinceLastAutomaticTipWritten = $timeSinceLastAutomaticTipWritten.Days

	[bool] $shouldShowTip = $false
	switch ($Config.AutoWritePowerShellTipCadence)
	{
		([tiPS.WritePowerShellTipCadence]::Never) { $shouldShowTip = $false; break }
		([tiPS.WritePowerShellTipCadence]::EverySession) { $shouldShowTip = $true; break }
		([tiPS.WritePowerShellTipCadence]::Daily) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 1; break }
		([tiPS.WritePowerShellTipCadence]::Weekly) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 7; break }
		([tiPS.WritePowerShellTipCadence]::Biweekly) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 14; break }
		([tiPS.WritePowerShellTipCadence]::Monthly) { $shouldShowTip = $daysSinceLastAutomaticTipWritten -ge 30; break }
	}

	if ($shouldShowTip)
	{
		[bool] $isSessionInteractive = TestPowerShellSessionIsInteractive
		if (-not $isSessionInteractive)
		{
			Write-Verbose "tiPS is configured to write an automatic tip now, but this session is non-interactive. tiPS will only write automatic tips when it is imported into an interactive PowerShell session. This prevents a tip from being written at unexpected times, such as when the user or an automated process runs PowerShell scripts."
			return
		}

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

function TestPowerShellSessionIsInteractive
{
	[CmdletBinding()]
	[OutputType([bool])]
	Param()

	if (-not [Environment]::UserInteractive)
	{
		Write-Debug "The [Environment]::UserInteractive property shows this PowerShell session is not interactive."
		return $false
	}

	[string[]] $typicalNonInteractiveCommandLineArguments = @(
		'-Command'
		'-c'
		'-EncodedCommand'
		'-e'
		'-ec'
		'-File'
		'-f'
		'-NonInteractive'
	)

	[string[]] $commandLineArgs = [Environment]::GetCommandLineArgs()
	Write-Debug "The PowerShell command line arguments are '$commandLineArgs'."

	[string[]] $nonInteractiveArgMatches = $commandLineArgs |
		Where-Object { $_ -in $typicalNonInteractiveCommandLineArguments }
	[bool] $isNonInteractive = $null -ne $nonInteractiveArgMatches -and $nonInteractiveArgMatches.Count -gt 0

	if ($isNonInteractive)
	{
		return $false
	}

	return $true
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
		[string] $lastAutomaticTipWrittenDateString = [System.IO.File]::ReadAllText($lastAutomaticTipWrittenDateFilePath)
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
	[System.IO.File]::WriteAllText($lastAutomaticTipWrittenDateFilePath, $LastAutomaticTipWrittenDate.ToString('o'))
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
