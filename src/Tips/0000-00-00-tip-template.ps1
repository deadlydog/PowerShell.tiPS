[Tip] $tip = [Tip]::new()
{
	Id = 'AShortEasyToRememberIdWithNoSpaces'
	Title = 'A brief title for the tip',
	TipText = 'A short description of the tip.',
	Example = 'Example code to demonstrate the tip.'
	Urls = @('https://OneOrMoreUrls', 'https://ToLearnMoreAboutTheTip')
	MinPowerShellVersion = [Version]::new(0, 0)
	Tags = @()
}
$Tips.Add($tip.Id, $tip)
