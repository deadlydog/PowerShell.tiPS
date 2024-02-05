$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-09')
$tip.Title = 'PSConfEU 2023 MiniCon'
$tip.TipText = @'
The PSConfEU 2023 MiniCon will be held on October 24, 2023. Save the date!

PSConfEU 2023 MiniCon is a free virtual event open to all of the PowerShell community. Wherever you are, join and say hi! There will be multiple sessions in several tracks, and many speakers and leaders of the community will be there to talk to you!
'@
$tip.Example = ''
$tip.Urls = @(
	'https://psconf.eu/'
	'https://app.gather.town/events/It0l-Wx8TQmTI93yQvs-'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.ExpiryDate = [DateTime]::Parse('2023-10-24') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
