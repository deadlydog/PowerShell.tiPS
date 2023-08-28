function WritePowerShellTipToTerminal
{
	[CmdletBinding()]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The PowerShell Tip to write to the terminal.')]
		[tiPS.PowerShellTip] $Tip
	)

	# Calculate how many header characters to put on each side of the title to make it look nice.
	[int] $numberOfCharactersInHeader = 80
	[int] $numberOfHeaderCharactersOnEachSideOfTitle =
		[Math]::Floor(($numberOfCharactersInHeader - ($Tip.Title.Length + 2)) / 2)
	[int] $additionalHeaderCharacterNeeded = 0
	if ($Tip.Title.Length % 2 -eq 1)
	{
		$additionalHeaderCharacterNeeded = 1
	}

	[string] $header =
		('-' * $numberOfHeaderCharactersOnEachSideOfTitle) +
		' ' + $Tip.Title + ' ' +
		('-' * ($numberOfHeaderCharactersOnEachSideOfTitle + $additionalHeaderCharacterNeeded))
	Write-Host $header -ForegroundColor Cyan

	Write-Host $Tip.TipText

	Write-Host 'Example: ' -ForegroundColor Yellow -NoNewline
	Write-Host $Tip.Example -ForegroundColor Yellow

	if ($Tip.UrlsAreProvided)
	{
		Write-Host 'More information: ' -ForegroundColor Green -NoNewline
		Write-Host $Tip.Urls -ForegroundColor Green
	}

	if ($Tip.MinPowerShellVersionIsProvided)
	{
		Write-Host 'Required PowerShell version or greater: ' -ForegroundColor Red -NoNewline
		Write-Host $Tip.MinPowerShellVersion -ForegroundColor Red
	}

	Write-Host ('-' * $numberOfCharactersInHeader) -ForegroundColor Cyan
}
