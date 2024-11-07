$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-11-06')
$tip.Title = 'Join the Research Triangle PowerShell User Group!'
$tip.TipText = @"
The Research Triangle User Group (RTPSUG) meets virtually, typically once or twice a month, to share ideas and discuss all things PowerShell. Community members often demo modules they've built or PowerShell things they have learned. It's free to attend and everyone is welcome. You can even reach out to the organizers to present something you've built or learned. Presentations are often uploaded to YouTube, allowing you to catch up on sessions you've missed. RTPSUG is an excellent way to stay up to date with both PowerShell technology and the PowerShell community.
"@
$tip.Example = ''
$tip.Urls = @(
	'https://www.meetup.com/research-triangle-powershell-users-group/'
	'https://www.youtube.com/c/RTPSUG/'
	'https://rtpsug.com'
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
