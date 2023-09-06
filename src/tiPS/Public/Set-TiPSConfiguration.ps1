function Set-TiPSConfiguration
{
	[CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'PartialConfiguration')]
	Param
	(
		[Parameter(Mandatory = $true, ParameterSetName = 'EntireConfiguration', ValueFromPipeline = $true)]
		[tiPS.Configuration] $Configuration,

		[Parameter(Mandatory = $false, ParameterSetName = 'PartialConfiguration', ValueFromPipelineByPropertyName = $true)]
		[tiPS.ModuleAutoUpdateCadence] $AutomaticallyUpdateModule = [tiPS.ModuleAutoUpdateCadence]::Never,

		[Parameter(Mandatory = $false, ParameterSetName = 'PartialConfiguration', ValueFromPipelineByPropertyName = $true)]
		[tiPS.WritePowerShellTipCadence] $AutomaticallyWritePowerShellTip = [tiPS.WritePowerShellTipCadence]::Never
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

		# If the AutomaticallyWritePowerShellTip parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('AutomaticallyWritePowerShellTip'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration AutoWritePowerShellTipCadence property', 'Set'))
			{
				$script:TiPSConfiguration.AutoWritePowerShellTipCadence = $AutomaticallyWritePowerShellTip
				WriteConfigurationToFile -Config $script:TiPSConfiguration
			}
		}

		[bool] $tiPSModuleIsImportedByProfile = Test-ProfileImportsTiPS
		if (-not $tiPSModuleIsImportedByProfile)
		{
			Write-Warning "tiPS can only perform automatic actions when it is imported into the current PowerShell session. Run 'Edit-ProfileToImportTiPS' to update your PowerShell profile import tiPS automatically when a new session starts, or manually add 'Import-Module -Name tiPS' to your profile file."
		}
	}
}
