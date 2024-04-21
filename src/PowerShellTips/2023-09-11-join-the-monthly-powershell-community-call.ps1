$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-11')
$tip.Title = 'Join the monthly PowerShell community call!'
$tip.TipText = @'
The PowerShell Community Call is held on the 3rd Thursday of every month at 9:30 AM US Pacific Time. Topics include PowerShell 7, Windows OpenSSH, PSEditorServices/VSCode-PowerShell, PSScriptAnalyzer, PowerShell Gallery, and any other projects owned by the PowerShell Team.

You can join the Teams live event at https://aka.ms/JoinPSCall. The call is recorded and posted on YouTube.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://github.com/PowerShell/PowerShell-RFC/blob/master/CommunityCall/README.md'
	'https://powershell.org/series/powershell-community-call/'
	'https://www.youtube.com/@powershellanddscteamchanne5739'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'
