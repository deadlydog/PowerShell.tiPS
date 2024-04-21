$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-08-28')
$tip.Title = 'View your command line history'
$tip.TipText = @'
PowerShell lets you view your session history with `Get-History` and it's alias `h`.
`Get-PSReadLineOption` used with `Get-Content` takes history reading further by allowing you to read your current users lifetime history.
'@
$tip.Example = 'Get-Content (Get-PSReadLineOption).HistorySavePath'
$tip.Urls = @(
	'https://learn.microsoft.com/powershell/module/psreadline/about/about_psreadline'
	'https://learn.microsoft.com/powershell/module/microsoft.powershell.core/get-history'
)
$tip.Category = [tiPS.TipCategory]::Terminal
$tip.Author = 'Emil Larsson (ehmiiz)'
