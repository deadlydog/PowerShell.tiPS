function Set-TiPSConfiguration
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param
	(
		[tiPS.Configuration] $Configuration
	)

	if ($PSCmdlet.ShouldProcess('tiPS configuration', 'Set'))
	{
		$script:TiPSConfiguration = $Configuration
		WriteConfigurationToFile -Config $script:TiPSConfiguration
	}
}
