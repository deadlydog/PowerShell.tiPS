[Tip] $tip = [Tip]::new()
{
	Id = 'PowerShellIsOpenSource'
	Title = 'PowerShell is open source',
	TipText = 'Did you know that PowerShell is open source? You can contribute to the project on GitHub.',
	Example = 'Example code to demonstrate the tip.'
	Urls = @('https://OneOrMoreUrls', 'https://ToLearnMoreAboutTheTip')
	MinPowerShellVersion = [Version]::new(3, 0)
	Tags = @()
}
$Tips.Add($tip.Id, $tip)
