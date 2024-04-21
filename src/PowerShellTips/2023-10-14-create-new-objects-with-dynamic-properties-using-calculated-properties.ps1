$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-14')
$tip.Title = 'Create new objects with dynamic properties using calculated properties'
$tip.TipText = @'
PowerShell is a dynamic language, which means that you can add properties to objects on the fly. By using calculated properties, you can add properties to output objects that are calculated from other properties on the input object, or data from external sources.

The easiest way to add calculated properties is by using the `Select-Object` cmdlet to return a new object back with the additional properties. You provide a hashtable to the `-Property` parameter, with a `Name` key for the name of the new property and an `Expression` key for the value. You can add as many calculated properties as you want.

The main difference between a calculated property and adding a property to an object with Add-Member is that calculated properties are added to a new output object, while Add-Member modifies the original object.
'@
$tip.Example = @'
# Get the first process and add a single calculated property to show how long it has been running.
> Get-Process | Select-Object -First 1 -Property ProcessName,StartTime,@{ Name = "RunningTime"; Expression = { (Get-Date) - $_.StartTime } }

ProcessName StartTime              RunningTime
----------- ---------              -----------
1Password   10/14/2023 12:59:24 PM 00:32:59.1893342


# Add multiple calculated properties (split into multiple lines for readability).
> Get-Process | Select-Object -First 1 -Property ProcessName,`
    StartTime,@{ Name = "RunningTime"; Expression = { (Get-Date) - $_.StartTime } },`
    WorkingSet,@{ Name = "WorkingSetMb"; Expression = { $_.WorkingSet / 1MB }}

ProcessName  : 1Password
StartTime    : 10/14/2023 12:59:24 PM
RunningTime  : 00:33:03.0717040
WorkingSet   : 73527296
WorkingSetMb : 70.12109375

# Get all processes with all original properties, plus the new calculated property.
> Get-Process | Select-Object -Property *,@{ Name = "RunningTime"; Expression = { (Get-Date) - $_.StartTime } }
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties'
	'https://4sysops.com/archives/add-a-calculated-property-with-select-object-in-powershell/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
