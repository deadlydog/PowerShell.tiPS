function Get-PowerShellTip
{
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
