$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-21')
$tip.Title = 'Learn about a random PowerShell cmdlet or topic'
$tip.TipText = @'
The tiPS module (which is bringing you these tips) is a great way to learn PowerShell every day. There are other ways to learn PowerShell every day too. Use the example code to learn about a random PowerShell cmdlet or topic. Try adding it to your daily routine, or even to your PowerShell profile.
'@
$tip.Example = @'
# Show the Help documentation for a random native cmdlet.
Get-Command -Module Microsoft*,Cim*,PS* | Get-Random | Get-Help -ShowWindow

# Show the Help documentation for a random PowerShell About topic.
Get-Random -input (Get-Help about*) | Get-Help -ShowWindow

# Open your PowerShell profile in VS Code so you can add the below code to it
# to automatically see Help documentation each time you start a new PowerShell
# session on Mondays before 10am.
code $Profile

[DateTime] $now = Get-Date
if ($now.DayOfWeek -eq 'Monday' -and $now.Hour -lt 10)
{
    Get-Command -Module Microsoft*,Cim*,PS* | Get-Random | Get-Help -ShowWindow
    Get-Random -input (Get-Help about*) | Get-Help -ShowWindow
}
'@
$tip.Urls = @(
	'https://jdhitsolutions.com/blog/essential-powershell-resources/'
)
$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
