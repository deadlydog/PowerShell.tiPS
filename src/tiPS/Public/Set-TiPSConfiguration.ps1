function Set-TiPSConfiguration
{
	[CmdletBinding()]
	Param
	(
		[tiPS.Configuration] $Configuration
	)

	$TiPSConfiguration = $Configuration
	WriteConfigurationToFile -Config $TiPSConfiguration
}
