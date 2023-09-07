function Write-PowerShellTip
{
	[CmdletBinding()]
	[Alias('Tips')]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId
	)

	[tiPS.PowerShellTip] $tip = Get-PowerShellTip -TipId $TipId
	WritePowerShellTipToTerminal -Tip $tip
}
