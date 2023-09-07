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
	}

	if ($shouldShowTip)
	{
		[bool] $tiPSModuleIsImportedByPowerShellProfile = Test-PowerShellProfileImportsTiPS
		if (-not $tiPSModuleIsImportedByPowerShellProfile)
		{
			Write-Verbose "tiPS is configured to write an automatic tip, but tiPS will only write automatic tips when it is imported from the PowerShell profile. This prevents a tip from being written when the user runs other tiPS cmdlets that cause tiPS to be imported into the current PowerShell session. Run 'Edit-ProfileToImportTiPS' to update your PowerShell profile import tiPS automatically when a new session starts, or manually add 'Import-Module -Name tiPS' to your profile file."
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
