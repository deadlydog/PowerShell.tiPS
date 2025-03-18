$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-17')
$tip.Title = 'Avoid null checks with the null-coalescing operators'
$tip.TipText = @'
PowerShell 7 introduced the null-coalescing operators `??` and `??=`. These operators allow you to simplify your code by avoiding explicit null checks.

The null-coalescing operator `??` returns the left-hand operand if it is not null; otherwise, it returns the right-hand operand. This is useful for providing default values.

The null-coalescing assignment operator `??=` assigns the right-hand operand to the left-hand operand only if the left-hand operand is null. This is useful to help ensure a variable has a value.
'@
$tip.Example = @'
# Example of using the null-coalescing operator.
$nullValue = $null
$realValue = 'Real Value'
$defaultValue = 'Default Value'
$result = $nullValue ?? $defaultValue # $result will be 'Default Value'.
$result = $realValue ?? $defaultValue # $result will be 'Real Value'.

# Example of using the null-coalescing assignment operator.
$existingValue = $null
$existingValue ??= 'Assigned Value' # $existingValue will be 'Assigned Value'.
$existingValue ??= 'Another Value' # $existingValue will still be 'Assigned Value'.

# Example of using the null-coalescing operator with a function.
function Get-Value {
	param ([string]$inputValue)
	return $inputValue ?? 'No Value Provided'
}

# Example of using the null-coalescing assignment operator with a function.
function Set-Value {
	param ([string]$inputValue)
	$inputValue ??= 'Default Value'
	return $inputValue
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators#null-coalescing-operator-'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators#null-coalescing-assignment-operator-'
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
