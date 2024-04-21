$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-31')
$tip.Title = 'Use Select-Object * to see all object properties'
$tip.TipText = @'
When an object is written to the console, PowerShell by default hides many of its properties. This is to make the output easier to read, but it can hide many useful properties that you may not know exist. This can be detrimental when interactively exploring objects in the console.

To see all properties of an object, and their values, use the `Select-Object` cmdlet with the `-Property *` parameter.
'@
$tip.Example = @'
# See the properties of an object shown by default (for comparison).
Get-Process | Select-Object -First 1

# See all properties of an object.
Get-Process | Select-Object -First 1 -Property *

# Shorthand alternatives for Select-Object -Property *.
Get-Process | Select-Object -First 1 *
Get-Process | Select-Object *
Get-Process | Select *
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-object'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
