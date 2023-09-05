function StartModuleUpdateIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[tiPS.Configuration] $Config
	)

	[DateTime] $modulesLastUpdateDate = ReadModulesLastUpdateDateOrDefault
	[TimeSpan] $timeSinceLastUpdate = [DateTime]::Now - $modulesLastUpdateDate

	[int] $daysNeededToTriggerUpdate = 0
	switch ($Config.AutoUpdateCadence)
	{
		([tiPS.ModuleAutoUpdateCadence]::Never) { $daysNeededToTriggerUpdate = -1; break }
		([tiPS.ModuleAutoUpdateCadence]::Daily) { $daysNeededToTriggerUpdate = 1; break }
		([tiPS.ModuleAutoUpdateCadence]::Weekly) { $daysNeededToTriggerUpdate = 7 ; break }
		([tiPS.ModuleAutoUpdateCadence]::BiWeekly) { $daysNeededToTriggerUpdate = 14; break }
		([tiPS.ModuleAutoUpdateCadence]::Monthly) { $daysNeededToTriggerUpdate = 30; break }
	}

	[bool] $moduleUpdateNeeded =
	$daysNeededToTriggerUpdate -gt 0 -and $timeSinceLastUpdate.Days -ge $daysNeededToTriggerUpdate
	if ($moduleUpdateNeeded)
	{
		UpdateModule
	}
	else
	{
		Write-Verbose "An auto-update of the tiPS module is not needed at this time."
	}
}

function UpdateModule
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-Verbose "Updating the tiPS module in a background job."
	Start-Job -ScriptBlock {
		Write-Verbose "Updating the tiPS module."
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Update-Module -Name 'tiPS' -Force

		Write-Verbose "Removing all but the latest version of the tiPS module to keep the modules directory clean."
		$latestModuleVersion = Get-InstalledModule -Name 'tiPS'
		$allModuleVersions = Get-InstalledModule -Name 'tiPS' -AllVersions
		$allModuleVersions |
			Where-Object { $_.Version -ne $latestModuleVersion.Version } |
			Uninstall-Module -Force
	}

	WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now)
}

function ReadModulesLastUpdateDateOrDefault
{
	[CmdletBinding()]
	[OutputType([DateTime])]
	Param()

	[DateTime] $modulesLastUpdateDate = [DateTime]::MinValue
	[string] $moduleUpdateDateFilePath = GetModulesLastUpdateDateFilePath
	if (Test-Path -Path $moduleUpdateDateFilePath -PathType Leaf)
	{
		[string] $modulesLastUpdateDateString = Get-Content -Path $moduleUpdateDateFilePath -Raw
		$modulesLastUpdateDate = [DateTime]::Parse($modulesLastUpdateDateString)
	}
	return $modulesLastUpdateDate
}

function WriteModulesLastUpdateDate
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[DateTime] $ModulesLastUpdateDate
	)

	[string] $moduleUpdateDateFilePath = GetModulesLastUpdateDateFilePath
	Write-Verbose "Writing modules last update date '$ModulesLastUpdateDate' to '$moduleUpdateDateFilePath'."
	$ModulesLastUpdateDate.ToString() | Set-Content -Path $moduleUpdateDateFilePath -Force -NoNewline
}

function GetModulesLastUpdateDateFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $moduleUpdateDateFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'ModulesLastUpdateDate.txt'
	return $moduleUpdateDateFilePath
}
