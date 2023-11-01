$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-11-01')
$tip.Title = "Use Get-Member to see an object's type, methods, and properties"
$tip.TipText = @'
When interactively exploring on the command line, use the `Get-Member` cmdlet to see an object's type, methods, properties, and events. This is especially useful when you're not sure what type of object you're working with, such as those returned by other cmdlets.

Get-Member will also show the type of each property and method, such as if they are a native property, an alias, or a property that was dynamically added using `Add-Member`. It also shows the parameters that each method accepts, and its return type.
'@
$tip.Example = @'
# See all of the properties and methods of the objects returned by Get-Process.
Get-Process | Get-Member

# Shorthand for Get-Member is gm.
Get-Process | gm

You can also use the -InputObject property instead of piping to Get-Member.
$process = Get-Process | Select-Object -First 1
Get-Member -InputObject $process
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member'
	'https://linuxhint.com/use-get-member-powershell/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
