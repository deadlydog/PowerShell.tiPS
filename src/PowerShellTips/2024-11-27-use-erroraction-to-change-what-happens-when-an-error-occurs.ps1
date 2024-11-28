$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-11-27')
$tip.Title = 'Use ErrorAction to change what happens when an error occurs'
$tip.TipText = @'
The `-ErrorAction` common parameter allows you to change what happens when a non-terminating error occurs in a cmdlet or script, such as when `Write-Error` is used. The default behavior is to display an error message and continue executing the script. You can change this behavior to:

- `Stop`: Display the error message and stop executing the script. That is, treat it as a terminating error.
- `Continue`: Display the error message and continue executing the script. This is the default.
- `SilentlyContinue`: Suppress the error message (so it is not written to the error stream) and continue executing the script.
- `Ignore`: Suppress the error message and continue executing the script. Unlike SilentlyContinue, Ignore doesn't add the error message to the $Error automatic variable.
- `Inquire`: Display the error message and prompt the user to continue or stop executing the script.
- `Break`: Display the error message and enter the debugger. Also breaks into the debugger when a terminating error occurs.

You can set the global behaviour for the current scope by setting the `$ErrorActionPreference` variable. This will be the default value for all cmdlets called that don't have the `-ErrorAction` parameter specified.
'@
$tip.Example = @'
function Test-ErrorAction {
    [CmdletBinding()] # This attribute is required to use the `-ErrorAction` common parameter.
    param()

    Write-Error "This is an error message"
}

Test-ErrorAction # Displays the error message and continues executing the script.
Test-ErrorAction -ErrorAction Stop # Displays the error message and stops executing the script.

$ErrorActionPreference = "SilentlyContinue" # Sets the global error action preference to suppress error messages.
Test-ErrorAction # Suppresses the error message and continues executing the script, because the global setting is SilentlyContinue.
Test-ErrorAction -ErrorAction Stop # Displays the error message and stops executing the script, because the `-ErrorAction` parameter overrides the global setting.
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters#-erroraction'
	'https://devblogs.microsoft.com/scripting/handling-errors-the-powershell-way/'
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
