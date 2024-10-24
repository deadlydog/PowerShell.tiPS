$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-10-24')
$tip.Title = 'PowerShell Best Practices and Style repository'
$tip.TipText = @'
The PoshCode/PowerShellPracticeAndStyle GitHub repository contains a collection of best practices and style guidelines for PowerShell scripts and modules. It is a great resource to help you write better PowerShell code that is more readable, maintainable, and performant. The repository includes guidelines on naming conventions, formatting, error handling, documentation, and more.

It is an open-source repo, so you can follow it to be notified of updates, and open pull requests or issues to contribute your own suggestions or improvements.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://github.com/PoshCode/PowerShellPracticeAndStyle'
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
