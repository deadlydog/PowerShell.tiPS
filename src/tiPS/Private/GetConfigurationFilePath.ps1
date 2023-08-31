function GetConfigurationFilePath
{
	[OutputType([string])]
	[CmdletBinding()]
	Param()

	[string] $applicationDataDirectoryPath = GetApplicationDataDirectoryPath
	[string] $configFilePath = [System.IO.Path]::Combine(
		$applicationDataDirectoryPath,
		"tiPSConfiguration.json"
	)
	return $configFilePath
}
