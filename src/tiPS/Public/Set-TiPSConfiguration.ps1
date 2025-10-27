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
	Old versions of the module are automatically deleted after a successful update.
	Valid values are Never, Daily, Weekly, Biweekly, and Monthly. Default is Never.

	.PARAMETER AutomaticallyWritePowerShellTip
	Whether to automatically write a PowerShell tip at session startup.
	Valid values are Never, EverySession, Daily, Weekly, Biweekly, and Monthly. Default is Never.

	.PARAMETER AutomaticallyWritePowerShellTipOption
	Controls how tips are selected when automatically showing tips.
	Valid values are CycleThroughAllTips (default) and UnseenTipsOnly.
	UnseenTipsOnly will only show tips that have not been shown yet.

	.PARAMETER TipRetrievalOrder
	The order in which to retrieve PowerShell tips.
	Valid values are NewestFirst, OldestFirst, and Random. Default is NewestFirst.

	.INPUTS
	You can pipe a [tiPS.Configuration] object containing the tiPS configuration to set, or
	a PSCustomObject with the individual properties to set
	(e.g. AutomaticallyUpdateModule and/or AutomaticallyWritePowerShellTip).

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

	.EXAMPLE
	Set-TiPSConfiguration -TipRetrievalOrder Random

	Set the tiPS configuration to retrieve PowerShell tips in random order.

	.EXAMPLE
	Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyWritePowerShellTipOption UnseenTipsOnly

	Set the tiPS configuration to automatically write a PowerShell tip every day, but only if there are tips that have not been shown yet.
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
		[tiPS.WritePowerShellTipCadence] $AutomaticallyWritePowerShellTip = [tiPS.WritePowerShellTipCadence]::Never,

		[Parameter(Mandatory = $false, ParameterSetName = 'PartialConfiguration', ValueFromPipelineByPropertyName = $true)]
		[tiPS.WritePowerShellTipOptions] $AutomaticallyWritePowerShellTipOption = [tiPS.WritePowerShellTipOptions]::CycleThroughAllTips,

		[Parameter(Mandatory = $false, ParameterSetName = 'PartialConfiguration', ValueFromPipelineByPropertyName = $true)]
		[Alias('TipOrder')]
		[tiPS.TipRetrievalOrder] $TipRetrievalOrder = [tiPS.TipRetrievalOrder]::NewestFirst
	)

	Process
	{
		# If the entire Configuration object parameter is passed in, set it and return.
		if ($PSBoundParameters.ContainsKey('Configuration'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration', 'Set'))
			{
				$script:TiPSConfiguration = $Configuration
			}
		}

		# If the AutomaticallyUpdateModule parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('AutomaticallyUpdateModule'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration AutoUpdateCadence property', 'Set'))
			{
				$script:TiPSConfiguration.AutoUpdateCadence = $AutomaticallyUpdateModule
			}
		}

		# If the AutomaticallyWritePowerShellTip parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('AutomaticallyWritePowerShellTip'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration AutoWritePowerShellTipCadence property', 'Set'))
			{
				$script:TiPSConfiguration.AutoWritePowerShellTipCadence = $AutomaticallyWritePowerShellTip
			}
		}

		# If the TipRetrievalOrder parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('TipRetrievalOrder'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration TipRetrievalOrder property', 'Set'))
			{
				$script:TiPSConfiguration.TipRetrievalOrder = $TipRetrievalOrder
			}
		}

		# If the AutomaticallyWritePowerShellTipOption parameter is passed in, set it.
		if ($PSBoundParameters.ContainsKey('AutomaticallyWritePowerShellTipOption'))
		{
			if ($PSCmdlet.ShouldProcess('tiPS configuration AutoWritePowerShellTipOptions property', 'Set'))
			{
				$script:TiPSConfiguration.AutoWritePowerShellTipOptions = $AutomaticallyWritePowerShellTipOption
			}
		}

		Write-Debug "Saving the tiPS configuration to the configuration file."
		WriteConfigurationToFile -Config $script:TiPSConfiguration

		Write-Debug "Ensuring the user's PowerShell profile imports the tiPS module if their config expects it."
		[bool] $automaticActionsAreConfigured =
			$script:TiPSConfiguration.AutoUpdateCadence -ne [tiPS.ModuleAutoUpdateCadence]::Never -or
			$script:TiPSConfiguration.AutoWritePowerShellTipCadence -ne [tiPS.WritePowerShellTipCadence]::Never
		if ($automaticActionsAreConfigured)
		{
			[bool] $tiPSModuleIsImportedByPowerShellProfile = Test-PowerShellProfileImportsTiPS
			if (-not $tiPSModuleIsImportedByPowerShellProfile)
			{
				Write-Warning "tiPS can only perform automatic actions when it is imported into the current PowerShell session. Run 'Add-TiPSImportToPowerShellProfile' to update your PowerShell profile import tiPS automatically when a new session starts, or manually add 'Import-Module -Name tiPS' to your profile file. If you are importing the module in a different way, such as in a script that is dot-sourced into your profile, you can ignore this warning."
			}
		}
	}
}
