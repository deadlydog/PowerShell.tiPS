$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-09')
$tip.Title = 'Reduce null checks by using null-conditional operators'
$tip.TipText = @'
PowerShell 7.1 introduced the null-conditional operators `?.` and `?[]`. These operators allow you to simplify your code by avoiding explicit null checks when accessing properties or elements of objects or arrays that may be null.

By default, if you try to index into a null array (e.g. $nullArray[0]), an exception will be thrown. Similarly, if you have Strict Mode enabled and try to access a property of a null object (e.g. $nullObject.SomeProperty), an exception will be thrown. The null-conditional operators allow you to avoid these exceptions and return null instead. You can even chain these together when accessing nested properties.

One slight caveat is that because '?' can be part of a variable name, you must use braces '{}' around the variable name. e.g. ${someVariable}?.Property or ${someVariable}?[0].
'@
$tip.Example = @'
# Example of using the null-conditional operator with an array.
$nullArray = $null
$element = $nullArray[0] # Throws exception 'InvalidOperation: Cannot index into a null array.'
$element = ${nullArray}?[0] # $element will be null without throwing an exception.

$array = @('Element1', 'Element2')
$element = ${array}?[0] # $element will be 'Element1'.

# Example of using the null-conditional operator with a property.
$nullObject = $null
$property = $nullObject.Property # $property will be null without throwing an exception, since Strict Mode is off.
$property = ${nullObject}?.Property # $property will be null without throwing an exception.

Set-StrictMode -Version Latest
$property = $nullObject.Property # Throws a PropertyNotFoundException, since Strict Mode is on.
$property = ${nullObject}?.Property # $property will be null without throwing an exception.

$object = [PSCustomObject]@{ Property = 'Value' }
$property = ${object}?.Property # $property will be 'Value'.

# Example with a REST API call and potentially null nested properties.
$result = Invoke-RestMethod -Uri https://dummyjson.com/products
$productWidthOrNull = ${result}?.{products}?[0]?.{dimensions}?.width
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4#null-conditional-operators--and-'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
