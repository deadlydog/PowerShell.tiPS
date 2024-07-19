$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-07-18')
$tip.Title = 'Use the -is operator to check a variable''s type'
$tip.TipText = @'
PowerShell provides the -is and -isnot operators to check if a variable is of a specific type. This is useful when you need to ensure that a variable is of a certain type before performing an operation on it. It is also more reliable and performant than using the GetType() method.
'@
$tip.Example = @'
(get-date) -is [DateTime] # Result is True
(get-date) -isnot [DateTime] # Result is False

$number = 42
$number -is [int] # Result is True
$number -is [string] # Result is False

# Can also use the -is operator with the type name as a string
$number -is 'int' # Result is True

if ($number -is [int]) {
    Write-Host "$number is an integer"
}

# Don't do this. It's less reliable and performant than using the -is operator.
if ($number.GetType().Name -eq 'Int32') {
    Write-Host "$number is an integer"
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_type_operators'
	'https://x.com/adbertram/status/1779473980631433681'
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
