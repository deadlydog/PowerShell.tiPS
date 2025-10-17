$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-16')
$tip.Title = 'PSConfEU 2026'
$tip.TipText = @'
The PowerShell Conference Europe (PSConfEU) is back for 2026! It will be held at Wiesbaden, Germany from June 1 - 4, 2026! This community-driven event brings together PowerShell enthusiasts, experts, and professionals from around the world to share knowledge, network, and learn about the latest developments in PowerShell. Book your tickets soon at https://psconf.eu to take advantage of early bird pricing!

You too can be a speaker at PSConfEU 2026! The call for speakers is open from October 14 - December 14, 2025. Submit your session ideas at https://sessionize.com/psconfeu26 to hopefully be selected.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://psconf.eu'
	'https://sessionize.com/psconfeu26'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
$tip.ExpiryDate = [DateTime]::Parse('2026-06-04') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Category meanings:
# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VS Code, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, keywords, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
