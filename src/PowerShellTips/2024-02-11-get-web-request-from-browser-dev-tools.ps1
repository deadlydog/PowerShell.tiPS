$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-02-11')
$tip.Title = 'Get web request from browser dev tools'
$tip.TipText = @'
Open up your web browser's developer tools (usually by pressing the F12 key) and navigate to the Network tab to see the network requests that are being made when you load a webpage. You can right-click on a request and copy it as PowerShell. This will copy the request and all headers as a PowerShell command that you can paste in your scripts.

This is an easy way to explore APIs and help automate flows that you typically do in the browser. You may even find APIs that are not listed in the web application's documentation, but beware that endpoints not listed in documentation may change without notice.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://x.com/_mbanana/status/1714337624674939081?s=20'
)
$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.
$tip.Author = 'Daniel Schroeder (deadlydog)'

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
