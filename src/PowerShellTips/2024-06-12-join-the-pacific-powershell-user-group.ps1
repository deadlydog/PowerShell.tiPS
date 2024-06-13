$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-06-12')
$tip.Title = 'Join the Pacific PowerShell User Group!'
$tip.TipText = @'
The Pacific PowerShell User Group meets virtually once a month to share ideas and discuss all things PowerShell. This is a casual meetup where everyone is welcome, from seasoned professionals to complete PowerShell newbies. Feel free to join. We would love to have you!
'@
$tip.Example = '
Start-Process "https://www.meetup.com/pacific-powershell-user-group/"
'
$tip.Urls = @(
	'https://www.meetup.com/pacific-powershell-user-group/'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Category meanings:
# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
