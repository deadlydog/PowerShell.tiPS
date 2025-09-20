$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-09-20')
$tip.Title = 'Adjust tiPS display frequency'
$tip.TipText = @'
You can adjust how often tips are automatically shown by using the `Set-TiPSConfiguration` command.

If you find that you are seeing the same tips over and over, it means that you've viewed all of the tips currently in the tiPS module.
While new tips do get added to the module over time, you may want to adjust how often tips are shown, such as changing the frequency from Daily to Weekly.

By default, tips are shown from newest to oldest, so even if you reduce the frequency you will still see newly added tips next.
'@
$tip.Example = @'
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Biweekly
'@
$tip.Urls = @(
	'https://github.com/deadlydog/PowerShell.tiPS?tab=readme-ov-file#-commands'
)
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

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
