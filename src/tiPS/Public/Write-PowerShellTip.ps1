function Write-PowerShellTip
{
	[CmdletBinding()]
	[Alias('Write-PSTip', 'Write-Tip', 'Tips')]
	Param
	(
		[Parameter(Mandatory = $false, HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $TipId
	)

	[string] $tip = Get-PowerShellTip -TipId $TipId
	Write-Host -Object $tip
}
