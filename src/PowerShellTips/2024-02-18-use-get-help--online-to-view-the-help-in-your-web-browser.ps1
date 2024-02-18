$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-02-18')
$tip.Title = 'Use Get-Help -Online to view the help in your web browser'
$tip.TipText = @'
You can use Get-Help to view the documentation for a cmdlet. This will use the help files on your local machine, which may be out of date. You can update your local files with Update-Help, but it uses more disk space and may take a while to run.

To easily ensure you are viewing the most up-to-date help, use the -Online parameter. This will open the help docs in your default web browser. Some people prefer to view the help docs in their web browser because it is easily searchable, and you can have multiple tabs open at once for different cmdlets.

CAUTION: The web browser will default to showing the help for the latest version of PowerShell. If you are using an older version of PowerShell, be sure to change the version picker to the version of PowerShell you are using.
'@
$tip.Example = @'
# Use your local help, which may not be up-to-date.
Get-Help Get-Item

# Open the help in your default web browser.
Get-Help Get-Item -Online
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-help?view=powershell-7.4'
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
