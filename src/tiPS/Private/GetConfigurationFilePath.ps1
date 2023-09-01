function GetConfigurationFilePath
{
	[OutputType([string])]
	[CmdletBinding()]
	Param()

	[string] $appDataDirectoryPath = GetApplicationDataDirectoryPath
	[string] $configFilePath = Join-Path -Path $appDataDirectoryPath -ChildPath 'tiPSConfiguration.json'
	return $configFilePath
}
