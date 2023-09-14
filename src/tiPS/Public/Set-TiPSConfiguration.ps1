function Set-TiPSConfiguration
{
<#
	.SYNOPSIS
	Set the tiPS configuration.

	.DESCRIPTION
	Set the entire or partial tiPS configuration.

	.PARAMETER Configuration
	The tiPS configuration object to set.
	All configuration properties are updated to match the provided object.
	No other properties may be provided when this parameter is used.

	.PARAMETER AutomaticallyUpdateModule
	Whether to automatically update the tiPS module at session startup.
	The module update is performed in a background job, so it does not block the PowerShell session from starting.
	This also means that the new module version will not be used until the next time the module is imported, or
	the next time a PowerShell session is started.
	Valid values are Never, Daily, Weekly, Monthly, and Yearly. Default is Never.

	.PARAMETER AutomaticallyWritePowerShellTip
	Whether to automatically write a PowerShell tip at session startup.
	Valid values are Never, Daily, Weekly, Monthly, and Yearly. Default is Never.

	.INPUTS
	You can pipe a [tiPS.Configuration] object containing the tiPS configuration to set, or
	a PsCustomObject with AutomaticallyUpdateModule and/or AutomaticallyWritePowerShellTip properties.

	.OUTPUTS
	None. The function does not return any objects.

	.EXAMPLE
	Set-TiPSConfiguration -Configuration $config

	Set the tiPS configuration.

	.EXAMPLE
	Set-TiPSConfiguration -AutomaticallyUpdateModule Weekly

	Set the tiPS configuration to automatically update the tiPS module every 7 days.

	.EXAMPLE
	Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily

	Set the tiPS configuration to automatically write a PowerShell tip every day.

	.EXAMPLE
	Set-TiPSConfiguration -AutomaticallyUpdateModule Never -AutomaticallyWritePowerShellTip Never

	Set the tiPS configuration to never automatically update the tiPS module or write a PowerShell tip.
#>
	[CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'PartialConfiguration')]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $true, ParameterSetName = 'EntireConfiguration', ValueFromPipeline = $true)]
		[ValidateNotNullOrEmpty()]
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

		[bool] $automaticActionsAreConfigured =
			$script:TiPSConfiguration.AutoUpdateCadence -ne [tiPS.ModuleAutoUpdateCadence]::Never -or
			$script:TiPSConfiguration.AutoWritePowerShellTipCadence -ne [tiPS.WritePowerShellTipCadence]::Never
		if ($automaticActionsAreConfigured)
		{
			[bool] $tiPSModuleIsImportedByPowerShellProfile = Test-PowerShellProfileImportsTiPS
			if (-not $tiPSModuleIsImportedByPowerShellProfile)
			{
				Write-Warning "tiPS can only perform automatic actions when it is imported into the current PowerShell session. Run 'Edit-ProfileToImportTiPS' to update your PowerShell profile import tiPS automatically when a new session starts, or manually add 'Import-Module -Name tiPS' to your profile file. If you are importing the module in a different way, such as in a script that is dot-sourced into your profile, you can ignore this warning."
			}
		}
	}
}
