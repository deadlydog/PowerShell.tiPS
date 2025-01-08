$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-01-08')
$tip.Title = 'Use Start-Transcript for a quick and easy log file'
$tip.TipText = @'
You can use the Start-Transcript cmdlet to easily create a log file of your PowerShell session. This is useful for keeping a record of what you did during an interactive session, or in your scripts to log any output for troubleshooting purposes.

If you do not specify the log file path, the log file will be created in the user's Home/Documents directory with a timestamped filename. The log file will remain locked by the PowerShell process until Stop-Transcript is called, so be sure to call Stop-Transcript when you are done.

It is often preferable to log output to a central logging system, however, that often requires much more code and may be overkill for some scenarios. Logging to a local file with Start-Transcript is a quick and easy alternative to capture output for later reference.
'@
$tip.Example = @'
try {
    # Log all script output to a file for easy reference later if needed.
    # $PSCommandPath will be the file path of the PowerShell script that is running.
    # Include the date and time in the log file name to make it unique instead of overwriting it every run.
    [string] $lastRunLogFilePath = "$PSCommandPath.LastRun.log"
    Start-Transcript -Path $lastRunLogFilePath

    # Put your script code here...
}
finally {
    Stop-Transcript
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.host/start-transcript'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.host/stop-transcript'
	'https://lazyadmin.nl/powershell/start-transcript/'
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
