$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-09-23')
$tip.Title = 'Press Tab twice to view all parameters, properties and possibilities'
$tip.TipText = @'
Add `Set-PSReadLineKeyHandler -Key Tab -Function Complete` to your PowerShell profile. This way you can press the Tab key twice after a command to view all possible parameters, properties, and possibilities.

The double tab method is similar to the normal tab completion, except it will show you all of the options at once instead of just one option at a time.

Note: Requires the `PSReadLine` module, which is included in PowerShell 5.1 and newer.
'@
$tip.Example = @'
# Open your PowerShell Profile:
notepad $profile

# Add the following line:
Set-PSReadLineKeyHandler -Key Tab -Function Complete
'@
$tip.Urls = @(
	'https://lazyadmin.nl/powershell/powershell-cheat-sheet/#good-to-know'
)
$tip.Category = [tiPS.TipCategory]::Terminal # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Rudy Mens (LazyAdmin)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
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
