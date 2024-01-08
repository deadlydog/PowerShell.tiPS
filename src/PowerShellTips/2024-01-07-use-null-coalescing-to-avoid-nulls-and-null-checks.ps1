$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-01-07')
$tip.Title = 'Use null-coalescing to avoid nulls and null checks'
$tip.TipText = @'
PowerShell 7.0 introduced the null-coalescing operator (??). This can help reduce the number of explicit null checks you need to write.

The null-coalescing operator syntax is as follows: <value> ?? <value-if-null>

If the value on the left-hand side of the operator is not null, the statement on the right-hand side of the operator will not be evaluated.

Null-coalescing can be used in expressions, conditional (if) statements, and variable assignments.
'@
$tip.Example = @'
# $x is null so the value on the right-hand side of the operator is returned.
> $x = $null
> $x ?? 'Default value for x'
Default value for x

# $y is not null so the value on the left-hand side of the operator is returned.
> $y = 'Explicit value for y'
> $y ?? 'Default value for y'
Explicit value for y

# The null-coalescing operator can be used in variable assignments.
# Since $x is null, $z is assigned the value of $y.
> $z = $x ?? $y
> $z
Explicit value for y

# Use the above expression ($z = $x ?? $y) instead of:
if ($null -eq $x) {
    $z = $y
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4#null-coalescing-operator-'
	'https://toastit.dev/2020/03/10/ps7now-null-conditional/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
