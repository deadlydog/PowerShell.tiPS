function Get-PowerShellTip
{
	[CmdletBinding(DefaultParameterSetName = 'Default')]
	[OutputType([tiPS.PowerShellTip])]
	Param
	(
		[Parameter(ParameterSetName = 'Default', Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId,

		[Parameter(ParameterSetName = 'AllTips', Mandatory = $false, HelpMessage = 'Return all tips.')]
		[switch] $AllTips
	)

	if ($AllTips)
	{
		return $script:Tips.Values
	}

	if ([string]::IsNullOrWhiteSpace($TipId))
	{
		$TipId = $script:Tips.Keys | Get-Random -Count 1
	}
	else
	{
		if (-not $script:Tips.ContainsKey($TipId))
		{
			Write-Error "A tip with ID '$TipId' does not exist."
			return
		}
	}

	[tiPS.PowerShellTip] $tip = $script:Tips[$TipId]
	return $tip
}
