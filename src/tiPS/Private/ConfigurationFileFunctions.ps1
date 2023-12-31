function GetConfigurationFilePath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = Get-TiPSDataDirectoryPath
	[string] $configFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'tiPSConfiguration.json'
	return $configFilePath
}

function ReadConfigurationFromFileOrDefault
{
	[CmdletBinding()]
	[OutputType([tiPS.Configuration])]
	Param()

	$config = [tiPS.Configuration]::new()
	[string] $configFilePath = GetConfigurationFilePath
	if (Test-Path -Path $configFilePath -PathType Leaf)
	{
		Write-Verbose "Reading configuration from '$configFilePath'."
		$config = [System.IO.File]::ReadAllText($configFilePath) | ConvertFrom-Json
	}
	return $config
}

function WriteConfigurationToFile
{
	[CmdletBinding()]
	[OutputType([void])]
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
