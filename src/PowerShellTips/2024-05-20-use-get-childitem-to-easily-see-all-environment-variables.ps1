$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-05-20')
$tip.Title = 'Use Get-ChildItem to easily see all environment variables'
$tip.TipText = @'
Need to quickly see all of the environment variables on your system? Use the `Get-ChildItem` cmdlet with the `Env:` drive to easily list them all with their values.

Alternatively, you can also use the Environment class functions `GetEnvironmentVariables()` and `GetEnvironmentVariable('EnvironmentVariableName')` to get the same information.
'@
$tip.Example = @'
# List all environment variables and their values.
Get-ChildItem Env:

# You can do the same thing using one of the aliases for Get-ChildItem.
gci Env:
dir Env:

# List a specific environment variable. e.g. the PATH environment variable.
Get-ChildItem Env:Path

# Alternatively, you can use the Environment class functions.
[Environment]::GetEnvironmentVariables()
[Environment]::GetEnvironmentVariable('Path')
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_environment_variables'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
