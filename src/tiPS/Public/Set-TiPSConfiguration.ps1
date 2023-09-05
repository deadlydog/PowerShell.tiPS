function Set-TiPSConfiguration
{
	[CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Default')]
	Param
	(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'ConfigurationObject')]
		[tiPS.Configuration] $Configuration,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[tiPS.ModuleAutoUpdateCadence] $AutomaticallyUpdateModule = [tiPS.ModuleAutoUpdateCadence]::Never
	)

	# If the entire Configuration object is passed in, set it and return.
	if ($PSBoundParameters.ContainsKey('Configuration'))
	{
		if ($PSCmdlet.ShouldProcess('tiPS configuration', 'Set'))
		{
			$script:TiPSConfiguration = $Configuration
			WriteConfigurationToFile -Config $script:TiPSConfiguration
		}
		return
	}

	# If the ModuleAutoUpdateCadence is passed in, set it.
	if ($PSBoundParameters.ContainsKey('AutomaticallyUpdateModule'))
	{
		if ($PSCmdlet.ShouldProcess('tiPS configuration AutomaticallyUpdateModule property', 'Set'))
		{
			$script:TiPSConfiguration.AutomaticallyUpdateModule = $AutomaticallyUpdateModule
			WriteConfigurationToFile -Config $script:TiPSConfiguration
		}
	}
}
