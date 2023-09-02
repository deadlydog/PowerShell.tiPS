function GetConfigurationFilePath
{
	[OutputType([string])]
	[CmdletBinding()]
	Param()

	[string] $appDataDirectoryPath = GetApplicationDataDirectoryPath
	[string] $configFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'tiPSConfiguration.json'
	return $configFilePath
}

function ReadConfigurationFromFile
{
	[CmdletBinding()]
	Param()

	$config = [tiPS.Configuration]::new()
	[string] $configFilePath = GetConfigurationFilePath
	if (Test-Path -Path $configFilePath -PathType Leaf)
	{
		Write-Verbose "Reading configuration from '$configFilePath'."
		$config = Get-Content -Path $configFilePath -Raw | ConvertFrom-Json
	}
	return $config
}

function WriteConfigurationToFile
{
	[CmdletBinding()]
	Param
	(
		[tiPS.Configuration] $Config
	)

	[string] $configFilePath = GetConfigurationFilePath

	if (-not (Test-Path -Path $configFilePath -PathType Leaf))
	{
		New-Item -Path $configFilePath -ItemType File -Force > $null
	}

	Write-Verbose "Writing configuration to '$configFilePath'."
	$Config | ConvertTo-Json -Depth 100 | Set-Content -Path $configFilePath -Force
}
