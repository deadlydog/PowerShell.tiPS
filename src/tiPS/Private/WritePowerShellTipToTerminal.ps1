function WritePowerShellTipToTerminal
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The PowerShell Tip to write to the terminal.')]
		[tiPS.PowerShellTip] $Tip
	)

	[ConsoleColor] $headerColor = [ConsoleColor]::Cyan
	[ConsoleColor] $tipTextColor = [ConsoleColor]::White
	[ConsoleColor] $exampleColor = [ConsoleColor]::Yellow
	[ConsoleColor] $urlsColor = [ConsoleColor]::Green
	[ConsoleColor] $minPowerShellVersionColor = [ConsoleColor]::Red


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
	Write-Host $header -ForegroundColor $headerColor

	Write-Host $Tip.TipText -ForegroundColor $tipTextColor

	if (-not [string]::IsNullOrWhiteSpace($Tip.Example))
	{
		Write-Host 'Example: ' -ForegroundColor $exampleColor -NoNewline
		Write-Host $Tip.Example -ForegroundColor $exampleColor
	}

	if ($Tip.UrlsAreProvided)
	{
		Write-Host 'More information: ' -ForegroundColor $urlsColor -NoNewline
		Write-Host $Tip.Urls -ForegroundColor $urlsColor
	}

	if ($Tip.MinPowerShellVersionIsProvided)
	{
		Write-Host 'Required PowerShell version or greater: ' -ForegroundColor $minPowerShellVersionColor -NoNewline
		Write-Host $Tip.MinPowerShellVersion -ForegroundColor $minPowerShellVersionColor
	}

	Write-Host ('-' * $numberOfCharactersInHeader) -ForegroundColor $headerColor
}
