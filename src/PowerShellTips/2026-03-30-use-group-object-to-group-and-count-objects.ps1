$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2026-03-30')
$tip.Title = 'Use Group-Object to group and count objects'
$tip.TipText = @'
The Group-Object cmdlet groups objects by the value of a specified property, similar to SQL's GROUP BY clause. Each group has a Count property showing how many objects share the same value, and a Group property containing the matching objects.

This is great for quickly summarizing data: counting files by extension, spotting duplicate values, grouping processes by status, and more. Use -NoElement when you only need the counts and don't need the grouped objects themselves (saves memory). Combine with Sort-Object to rank results.
'@
$tip.Example = @'
# Count files in a directory by extension.
Get-ChildItem -Path 'C:\Temp' | Group-Object -Property Extension

# Show only the count and name (no grouped objects) for a lighter result.
Get-ChildItem -Path 'C:\Temp' | Group-Object -Property Extension -NoElement | Sort-Object Count -Descending

# Find duplicate values in an array.
$fruits = 'apple','banana','apple','cherry','banana','apple'
$fruits | Group-Object | Where-Object Count -gt 1

# Group running processes by their status, then inspect one group.
$groups = Get-Process | Group-Object -Property Responding
$notResponding = ($groups | Where-Object Name -eq 'False').Group

# Group services by start type and show a summary.
Get-Service | Group-Object StartType -NoElement | Sort-Object Count -Descending
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/group-object'
	'https://adamtheautomator.com/powershell-group-object/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Copilot'

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
