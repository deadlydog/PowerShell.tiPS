$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-24')
$tip.Title = 'Use trap to catch unhandled exceptions'
$tip.TipText = @'
Similarly to how you can catch terminating errors (i.e. exceptions) with a try-catch block, you can use the `trap` keyword to catch unhandled terminating errors in a script or function. The trap keyword is a global exception handler, allowing you to catch and handle terminating errors in the current scope and all child scopes.

When an exception is caught by a trap statement, you can use the `break` statement to abort execution of the script or function, or use the `continue` statement to continue execution where the script left off. If you do not use either of these statements, execution will continue after the trap statement.

You can defined multiple traps at different scopes. Also, like catch blocks, you can restrict trap blocks to only catch exceptions of a certain type.
'@
$tip.Example = @'
trap {
    [bool] $imFeelingLucky = (Get-Random -Maximum 10) -eq 5
    if ($imFeelingLucky)
    {
        Write-Warning "I'm feeling lucky, so I'll continue execution."
        continue
    }
    Write-Error "The following unhandled error occurred, so exiting script: $_"
    break
}

InvokingAFunctionThatDoesNotExist # Will throw an exception, which will be caught by the trap.

Write-Output "I see you're feeling lucky today."
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_trap'
	'https://www.sconstantinou.com/powershell-trap/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
