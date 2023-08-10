function Get-PowerShellTip
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId
	)

	if ([string]::IsNullOrWhiteSpace($TipId))
	{
		$TipId = $Tips.Keys | Get-Random -Count 1
	}

	[Tip] $tip = $Tips[$TipId]
	return $tip
}
