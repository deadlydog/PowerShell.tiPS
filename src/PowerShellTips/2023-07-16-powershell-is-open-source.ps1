$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-07-16')
$tip.Title = 'PowerShell is open source'
$tip.TipText = 'Did you know that PowerShell is open source? You can contribute to the project on GitHub.'
$tip.Example = ''
$tip.Urls = @(
	'https://github.com/PowerShell/PowerShell'
)
$tip.Category = [tiPS.TipCategory]::Community
$tip.Author = 'Daniel Schroeder (deadlydog)'
