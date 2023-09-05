function Set-TiPSConfiguration
{
	[CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'PartialConfiguration')]
	Param
	(
		[Parameter(Mandatory = $true, ParameterSetName = 'EntireConfiguration', ValueFromPipeline = $true)]
		[tiPS.Configuration] $Configuration,

		[Parameter(Mandatory = $false, ParameterSetName = 'PartialConfiguration', ValueFromPipelineByPropertyName = $true)]
		[tiPS.ModuleAutoUpdateCadence] $AutomaticallyUpdateModule = [tiPS.ModuleAutoUpdateCadence]::Never
	)

	Process
	{
		# If the entire Configuration object parameter is passed in, set it and return.
		if ($PSBoundParameters.ContainsKey('Configuration'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration', 'Set'))
			{
				$script:TiPSConfiguration = $Configuration
				WriteConfigurationToFile -Config $script:TiPSConfiguration
			}
			return
		}

		# If the AutomaticallyUpdateModule parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('AutomaticallyUpdateModule'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration AutoUpdateCadence property', 'Set'))
			{
				$script:TiPSConfiguration.AutoUpdateCadence = $AutomaticallyUpdateModule
				WriteConfigurationToFile -Config $script:TiPSConfiguration
			}
		}
	}
}
