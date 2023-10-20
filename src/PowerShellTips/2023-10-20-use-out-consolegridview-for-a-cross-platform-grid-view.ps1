$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-20')
$tip.Title = 'Use Out-ConsoleGridView for a cross-platform grid view'
$tip.TipText = @'
The Out-GridView cmdlet is very useful, but it only works on Windows. The Microsoft.PowerShell.ConsoleGuiTools module provides a cross-platform alternative called Out-ConsoleGridView. Rather than opening a new window, it displays the grid view in the current terminal window.

You can use Out-ConsoleGridView to display a table of data that the user is able to interactively navigate. The user can select rows from the list that can be saved to a variable or piped to another command, allowing you to perform actions on the selected rows.
'@
$tip.Example = @'
Install-Module Microsoft.PowerShell.ConsoleGuiTools

Get-Process | Out-ConsoleGridView -Title "Select processes to return" | Select-Object -Property ProcessName,Id
'@
$tip.Urls = @(
	'https://github.com/PowerShell/GraphicalTools/'
)
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
