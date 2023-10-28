$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-28')
$tip.Title = 'Write events to the Windows Event Viewer with Write-EventLog'
$tip.TipText = @'
When logging from scripts or modules, a common practice is to log to the console or a log file. Another option is to log to the Windows Event Viewer with the `Write-EventLog` cmdlet. This allows you to log to the Application, System, or Security logs, or create a new log specifically for your script or module.

This can be especially useful when using a centralized monitoring solution like System Center Orchestrator or Azure Monitor, as they can monitor the Windows Event Viewer from multiple servers for specific events. You can also use the `Get-EventLog` cmdlet to manually retrieve events from the Windows Event Viewer on the local or remote computers.

The `Write-EventLog` cmdlet is available on Windows PowerShell and PowerShell, but can only be used on Windows.
The `New-EventLog` and `Write-EventLog` cmdlets may require elevated permissions (i.e. run as admin).
'@
$tip.Example = @'
# You must first create the "Source" before you can write to it.
New-EventLog -LogName Application -Source "My Script"
Write-EventLog -LogName Application -Source "My Script" -EntryType Information -EventID 1 -Message "This is a test message."

# You can also create a new log just for your script.
New-EventLog -LogName "My Script Log" -Source "My Script"
Write-EventLog -LogName "My Script Log" -Source "My Script" -EntryType Error -EventID 99 -Message "This is a test error message."
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-eventlog'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/write-eventlog'
	'https://devblogs.microsoft.com/scripting/how-to-use-powershell-to-write-to-event-logs/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
