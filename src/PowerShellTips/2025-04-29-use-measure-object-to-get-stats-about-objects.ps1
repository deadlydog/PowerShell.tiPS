$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-29')
$tip.Title = 'Use Measure-Object to get stats about objects'
$tip.TipText = @'
You can use the Measure-Object cmdlet to get statistics about objects in PowerShell. This cmdlet can be used to calculate the sum, average, minimum, maximum, and count of numeric properties in objects. When used with text input, it can count characters, words, and lines.

The cmdlet returns an object containing properties for each statistic, but the statistic is only actually calculated if you provided the switch for it. For example, if you only provide the -Sum switch, the Sum property will contain the sum of the values, but the Average property will be null since the -Average switch was not provided.
'@
$tip.Example = @'
# Get all statistics about a range of numbers.
1..10 | Measure-Object -Average -Sum -Minimum -Maximum -StandardDeviation

# Get all statistics about a string.
"Hello there" | Measure-Object -Character -Word -Line

# Count the number of words in a file.
Get-Content 'C:\path\to\file.txt' | Measure-Object -Word

# Calculate the total size (Length) of all files in the current directory.
Get-ChildItem | Measure-Object -Property Length -Sum

# In an array of objects, find the one with the maximum value of the Num property.
@{num=3}, @{num=4}, @{num=5} | Measure-Object -Maximum Num

# Get the total and maximum CPU time and paged memory size of all processes.
Get-Process | Measure-Object -Property CPU,PagedMemorySize -Sum -Maximum
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-object'
	'https://adamtheautomator.com/powershell-measure-object/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
