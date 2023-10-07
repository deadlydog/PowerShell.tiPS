$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-06')
$tip.Title = 'Use Ctrl+R to search your terminal history'
$tip.TipText = @'
When in your command prompt, press Ctrl+R to reverse search your terminal history. As you type, it will show the most recent matching command. This is a great way to find a command you ran previously, but can't remember the exact command or parameters.

If you press Ctrl+R again, it will show the next most recent matching command. You can keep pressing Ctrl+R to cycle through all matching commands. If you go past the command you wanted, press Ctrl+S and it will cycle through the matching commands in the opposite direction.

Note: Requires the `PSReadLine` module, which is included in PowerShell 5.1 and newer.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://woshub.com/powershell-commands-history/'
)
$tip.Category = [tiPS.TipCategory]::Terminal # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
