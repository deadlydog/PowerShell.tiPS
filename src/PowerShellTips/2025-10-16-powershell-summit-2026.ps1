$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-16')
$tip.Title = 'PowerShell + DevOps Global Summit 2026'
$tip.TipText = @'
The PowerShell + DevOps Global Summit is returning in 2026! It will be held in Bellevue, Washington, USA from April 13 - 16, 2026. This community-driven event brings together PowerShell and DevOps enthusiasts, experts, and professionals from around the world to share knowledge, network, and learn about the latest developments in PowerShell. Register to attend at https://www.powershellsummit.org.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://www.powershellsummit.org'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
$tip.ExpiryDate = [DateTime]::Parse('2026-04-16') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

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
