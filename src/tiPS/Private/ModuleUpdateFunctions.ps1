function GetModulesLastUpdateDateFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = GetApplicationDataDirectoryPath
	[string] $moduleUpdateDateFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'ModulesLastUpdateDate.txt'
	return $moduleUpdateDateFilePath
}

function ReadModulesLastUpdateDate
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

function StartModuleUpdateIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[tiPS.Configuration] $Config
	)

	[DateTime] $modulesLastUpdateDate = ReadModulesLastUpdateDate
	[TimeSpan] $timeSinceLastUpdate = [DateTime]::Now - $modulesLastUpdateDate

	[int] $daysNeededToTriggerUpdate = 0
	switch ($Config.AutoUpdateCadence)
	{
		[tiPS.ModuleAutoUpdateCadence]::Never { $daysNeededToTriggerUpdate = -1 }
		[tiPS.ModuleAutoUpdateCadence]::Daily { $daysNeededToTriggerUpdate = 1 }
		[tiPS.ModuleAutoUpdateCadence]::Weekly { $daysNeededToTriggerUpdate = 7 }
		[tiPS.ModuleAutoUpdateCadence]::BiWeekly { $daysNeededToTriggerUpdate = 14 }
		[tiPS.ModuleAutoUpdateCadence]::Monthly { $daysNeededToTriggerUpdate = 30 }
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
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Update-Module -Name 'tiPS' -Force
	}

	WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now)
}
