$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-09-03')
$tip.Title = 'Array Lists'
$tip.TipText = @'
An Array list is similar to an array, but it does not have a fixed size like an array does.

With a fixed-sized array and you add an item to the array, the array is actually recreated with the additional item. This can impact performance, when working with thousands of items.

Another concern with fixed-size arrays is that there's no simple method to remove an item.

'@
$tip.Example = @'
# In PowerShell, you can create an Array list using the `System.Collections.ArrayList` class. Here's how you can create and use an Array list:

[System.Collections.ArrayList]$computers = @('Server1', 'Server2', 'Server3')

# To create an empty array ready to add items

$computers=New-Object System.Collections.ArrayList
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/training/modules/work-arrays-hash-tables-window-powershell-scripts/3-work-array-lists-windows'
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.5#arraylist'
)
$tip.Category = [tiPS.TipCategory]::Performance # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Adrian Muscat (adrimus)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
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
