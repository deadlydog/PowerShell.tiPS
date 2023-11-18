$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-11-18')
$tip.Title = 'The ternary operator can replace if-else statements'
$tip.TipText = @'
PowerShell 7.0 introduced the ternary operator. This can useful for replacing very short if-else statements.

The ternary operator syntax is as follows: <condition> ? <if-true> : <if-false>

While the ternary operator can reduce the number of lines required, not everyone will find it more readable than an if-else statement. Use your best judgement when deciding whether to use the ternary operator or an if-else statement, and remember that it is only available in PowerShell 7.0 and later.
'@
$tip.Example = @'
# Example of using an if-else statement to set a variable.
if (Test-Path $path) {
    $message = "Path exists"
}
else {
    $message = "Path not found"
}

# The equivalent statement using the ternary operator.
$message = (Test-Path $path) ? "Path exists" : "Path not found"

# Another example of using the ternary operator to toggle a service between started and stopped.
$service = Get-Service ServiceNameToToggleOnOrOff
$service.Status -eq 'Running' ? (Stop-Service $service) : (Start-Service $service)
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators#ternary-operator--if-true--if-false'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if#using-the-ternary-operator-syntax'
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
