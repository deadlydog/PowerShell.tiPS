$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('0001-01-01') # Change to today's date and remove this comment.
$tip.Title = 'Tip template'
$tip.TipText = @'
A short description of the tip.

This can be multiple lines.
'@
$tip.Example = 'Example code to demonstrate the tip. This can also be multiple lines if needed.'
$tip.Urls = @('https://OneTwoOrThreeUrls', 'https://ToLearnMoreAboutTheTip')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, Syntax, Terminal, or Other.
