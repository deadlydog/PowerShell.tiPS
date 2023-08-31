function Set-TiPSConfiguration
{
	[CmdletBinding()]
	Param
	(
		[tiPS.Configuration] $Configuration
	)

	$script:TiPSConfiguration = $Configuration
	WriteConfigurationToFile -Config $script:TiPSConfiguration
}
