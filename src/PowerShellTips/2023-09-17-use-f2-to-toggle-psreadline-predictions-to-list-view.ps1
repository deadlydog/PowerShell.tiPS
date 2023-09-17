$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-17')
$tip.Title = 'Use F2 to toggle PSReadLine predictions to list view'
$tip.TipText = @'
PSReadLine v2.1.0 introduced history-based predictions. As you type, PSReadLine will show you a command that you previously typed, thinking that you may want to run the same command again. You can use the right-arrow to accept the suggestion.

If you want to see more predictions, you can press the F2 key to swap from Inline View (which only shows a single suggestion), to List View, which shows many. You can then use the up and down arrow keys to select a command from the list.

Use 'Update-Module -Name PSReadLine' to update to the latest version of PSReadLine and use these features.
'@
$tip.Example = 'Type "Get-" and then press F2 to see a list of commands that you have previously typed that start with "Get-"'
$tip.Urls = @('https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/', 'https://learn.microsoft.com/en-us/powershell/module/psreadline/')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Terminal # Community, CoreCmdlet, Editor, Module, Syntax, Terminal, or Other.
