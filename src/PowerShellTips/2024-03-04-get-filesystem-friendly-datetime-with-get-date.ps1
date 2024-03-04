$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-03-04')
$tip.Title = 'Get filesystem friendly DateTime with Get-Date'
$tip.TipText = @'
It's common to use a date timestamp in a filename for things like log files. The default output of Get-Date includes characters that are not valid for the filesystem, such as colons. You can use the -Format parameter to specify a custom format, or leverage the built-in FileDate and FileDateTime formats that are filesystem friendly.
'@
$tip.Example = @'
PS> Get-Date
Monday, March 4, 2024 9:43:18 AM

PS> Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
2024-03-04_09-43-37

PS> Get-Date -Format FileDate
20240304

PS> Get-Date -Format FileDateTime
20240304T0943556270

PS> Get-Date -Format FileDateTimeUniversal
20240304T1544081746Z
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.4#-format'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
