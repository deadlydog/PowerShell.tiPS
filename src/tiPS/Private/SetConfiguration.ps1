function SetConfiguration
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
