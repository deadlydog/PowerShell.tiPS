[Tip] $tip = [Tip]::new()
$tip.Id = 'AShortEasyToRememberIdWithNoSpaces'
$tip.CreatedDate = [DateTime]::Parse('2023-07-16') # Use today's date.
$tip.Title = 'A brief title for the tip'
$tip.TipText = @'
A short description of the tip.

This can be multiple lines.
'@
$tip.Example = 'Example code to demonstrate the tip.'
$tip.Urls = @('https://OneOrMoreUrls', 'https://ToLearnMoreAboutTheTip')
$tip.MinPowerShellVersion = [Version]::new(0, 0)
$tip.Tags = @()
