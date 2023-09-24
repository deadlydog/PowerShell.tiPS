function StartModuleUpdateIfNeeded
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The tiPS configuration to use to determine if the module should be updated.')]
		[ValidateNotNullOrEmpty()]
		[tiPS.Configuration] $Config
	)

	# For performance reasons, check if we should never update the module before doing anything else.
	if ($Config.AutoUpdateCadence -eq [tiPS.ModuleAutoUpdateCadence]::Never)
	{
		return
	}

	[DateTime] $modulesLastUpdateDate = ReadModulesLastUpdateDateOrDefault
	[TimeSpan] $timeSinceLastUpdate = [DateTime]::Now - $modulesLastUpdateDate
	[int] $daysSinceLastUpdate = $timeSinceLastUpdate.Days

	[bool] $moduleUpdateNeeded = $false
	switch ($Config.AutoUpdateCadence)
	{
		([tiPS.ModuleAutoUpdateCadence]::Never) { $moduleUpdateNeeded = $false; break }
		([tiPS.ModuleAutoUpdateCadence]::Daily) { $moduleUpdateNeeded = $daysSinceLastUpdate -ge 1; break }
		([tiPS.ModuleAutoUpdateCadence]::Weekly) { $moduleUpdateNeeded = $daysSinceLastUpdate -ge 7 ; break }
		([tiPS.ModuleAutoUpdateCadence]::BiWeekly) { $moduleUpdateNeeded = $daysSinceLastUpdate -ge 14; break }
		([tiPS.ModuleAutoUpdateCadence]::Monthly) { $moduleUpdateNeeded = $daysSinceLastUpdate -ge 30; break }
	}

	if ($moduleUpdateNeeded)
	{
		UpdateModule
	}
	else
	{
		Write-Debug "An auto-update of the tiPS module is not needed at this time."
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

	[DateTime] $todayWithoutTime = [DateTime]::Now.Date # Exclude the time for a better user experience.
	WriteModulesLastUpdateDate -ModulesLastUpdateDate $todayWithoutTime
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
		[string] $modulesLastUpdateDateString = [System.IO.File]::ReadAllText($moduleUpdateDateFilePath)
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
	[System.IO.File]::WriteAllText($moduleUpdateDateFilePath, $ModulesLastUpdateDate.ToString())
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
