$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-05-20')
$tip.Title = 'Assign array items to variables in one line'
$tip.TipText = @'
Often times we have an array with multiple items that we want to assign to individual variables. Instead of assigning each item to a variable on a separate line, you can assign all the items to variables on a single line.

Be careful though, as if there are more items in the array than variables you are assigning to, the remaining items will all be assigned to the last variable. If there are more variables than items in the array, the extra variables will be assigned `$null`. To avoid this you can explicitly specify the indexes of the array items you want to assign to each variable, or use the range operator.

You can also use the `-split` operator to create an array of items from a string.
'@
$tip.Example = @'
$items = 'One', 'Two', 'Three'

# Instead of doing this:
$one = $items[0]
$two = $items[1]
$three = $items[2]

# You can do this:
$one, $two, $three = $items

# Be careful though:
$one, $two = $items
# $one will be 'One', but $two will be an array containing 'Two','Three'.

$one, $two, $three, $four = $items
# $one will be 'One', $two will be 'Two', $three will be 'Three', and $four will be $null

# Use array indexing to get only the first two items.
$one, $two = $items[0..1] # Or $items[0,1]

# You can also use the `-split` operator to create an array of items from a string.
$one, $two, $three = 'One Two Three' -split ' '
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays'
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays'
	'https://x.com/adbertram/status/1790396866099634606'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
