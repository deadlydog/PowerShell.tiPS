function Get-PowerShellTip
{
<#
	.SYNOPSIS
	Get a PowerShellTip object. If no parameters are specified, a random tip is returned.

	.DESCRIPTION
	Get a PowerShellTip object. If no parameters are specified, a random tip is returned.

	.INPUTS
	You can pipe a [string] of the ID of the tip to retrieve, or a PsCustomObject with a [string] 'Id' property.

	.OUTPUTS
	A [tiPS.PowerShellTip] object representing the PowerShell tip.

	If the -AllTips switch is provided, a [System.Collections.Specialized.OrderedDictionary] is returned.

	.PARAMETER Id
	The ID of the tip to retrieve. If not supplied, a random tip will be returned.

	.PARAMETER AllTips
	Return all tips.

	.EXAMPLE
	Get-PowerShellTip

	Get a random tip.

	.EXAMPLE
	Get-PowerShellTip -Id '2023-07-16-powershell-is-open-source'

	Get the tip with the specified ID. If no tip with the specified ID exists, an error is written.

	.EXAMPLE
	Get-PowerShellTip -AllTips

	Get all tips.

	.EXAMPLE
	'2023-07-16-powershell-is-open-source' | Get-PowerShellTip

	Pipe a [string] of the ID of the tip to retrieve.

	.EXAMPLE
	[PSCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Get-PowerShellTip

	Pipe an object with a [string] 'Id' property.
#>

	[CmdletBinding(DefaultParameterSetName = 'Default')]
	[OutputType([tiPS.PowerShellTip], ParameterSetName = 'Default')]
	[OutputType([System.Collections.Specialized.OrderedDictionary], ParameterSetName = 'AllTips')]
	Param
	(
		[Parameter(ParameterSetName = 'Default', Mandatory = $false,
			ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $Id,

		[Parameter(ParameterSetName = 'AllTips', Mandatory = $false, HelpMessage = 'Return all tips.')]
		[switch] $AllTips
	)

	Process
	{
		if ($AllTips)
		{
			return ReadAllPowerShellTipsFromJsonFile
		}

		if ([string]::IsNullOrWhiteSpace($Id))
		{
			$Id = $script:Tips.Keys | Get-Random -Count 1
		}
		else
		{
			if (-not $script:Tips.ContainsKey($Id))
			{
				Write-Error "A tip with ID '$Id' does not exist."
				return
			}
		}

		[tiPS.PowerShellTip] $tip = $script:Tips[$Id]
		return $tip
	}
}
