function GetConfiguration
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
