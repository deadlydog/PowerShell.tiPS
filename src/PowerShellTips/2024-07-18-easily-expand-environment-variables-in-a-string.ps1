$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-07-18')
$tip.Title = 'Easily expand environment variables in a string'
$tip.TipText = @'
You can use the `[System.Environment]::ExpandEnvironmentVariables()` method to easily expand environment variables in a string. Simply wrap the environment variable name in % characters. You can even expand multiple environment variables in a single string.
'@
$tip.Example = @'
# Expand a single environment variable and store it in a variable.
$tempDirectoryPath = [System.Environment]::ExpandEnvironmentVariables('%TEMP%')

# Alternative is to use the $Env: syntax to retrieve a single environment variable.
$tempDirectoryPath = $Env:TEMP

# Expand multiple environment variables in a string.
[System.Environment]::ExpandEnvironmentVariables('My system drive is %SystemDrive% and my system root is %SystemRoot%')
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.environment.expandenvironmentvariables'
	'https://x.com/adbertram/status/1777421663581130856'
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
