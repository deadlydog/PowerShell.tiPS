$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-11-27')
$tip.Title = 'Use ErrorVariable to save cmdlet errors to a variable'
$tip.TipText = @'
When running a cmdlet in PowerShell, you can use the `-ErrorVariable` parameter to save any errors that occur during the cmdlet's execution to a variable. This can be useful for capturing errors and handling them programmatically. There is also a `-WarningVariable` parameter that works similarly for warnings.

You can also couple these with the `-ErrorAction` and `-WarningAction` common parameters to control how errors and warnings are handled. For example, you can set `-ErrorAction` to `SilentlyContinue` to suppress errors from being displayed on the console, while still capturing them in the error variable.
'@
$tip.Example = @'
function Test-ErrorVariable {
    [CmdletBinding()] # This attribute is required to use the `-ErrorVariable` common parameter.
    param()

    Write-Error "This is an error message that should be IGNORED"
    Write-Error "This is another error message"
}

# You don't need to initialize the error and warning variable, but it's a good practice.
$errors = @()
$warnings = @()

# Use ErrorAction SilentlyContinue to suppress errors from being displayed on the console while still capturing them in the errors variable.
Test-ErrorVariable -WarningVariable warnings -ErrorVariable errors -ErrorAction SilentlyContinue

if ($errors) {
    # Here you can inspect the errors and handle them as needed.
    $errors | ForEach-Object {
        if ($_ -like '*IGNORED*') {
            Write-Verbose "Ignoring error: $_"
        } else {
            Write-Error "Error: $_"
        }
    }
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters#-errorvariable'
	'https://stuart-moore.com/powershell-using-errorvariable-and-warningvariable/'
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
