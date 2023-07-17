[Tip] $tip = [Tip]::new()
$tip.Id = 'AShortEasyToRememberIdWithNoSpaces'
$tip.Title = 'A brief title for the tip'
$tip.TipText = @'
A short description of the tip.

This can be multiple lines.
'@
$tip.Example = 'Example code to demonstrate the tip.'
$tip.Urls = @('https://OneOrMoreUrls', 'https://ToLearnMoreAboutTheTip')
$tip.MinPowerShellVersion = [Version]::new(0, 0)
$tip.Tags = @()

$Tips.Add($tip.Id, $tip)
