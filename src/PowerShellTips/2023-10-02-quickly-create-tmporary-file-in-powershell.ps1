$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-02')
$tip.Title = 'Quickly create temporary file in PowerShell'
$tip.TipText = @'
Quickly create a temporary file using dotnet class.

This is handy when you want save data to a temporary log file and not worry about path/permissions/filename.
Temporary file will be created in "C:\Users\USER\AppData\Local\Temp\1\some-tmp.tmp" and automatically cleaned up after reboot.
'@
$tip.Example = @'
$tmpFile = [System.IO.Path]::GetTempFileName()
# Using native PowerShell cmdlet
$tmpFile = New-TemporaryFile
# Easily write/read/remove
"Some data to be saved" | Out-File $tmpFile
# Cleanup when you no longer need it
Remove-Item $tmpFile
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.io.path.gettempfilename?view=net-7.0#system-io-path-gettempfilename'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-temporaryfile'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
