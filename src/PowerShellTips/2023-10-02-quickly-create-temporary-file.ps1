$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-02')
$tip.Title = 'Quickly create temporary file'
$tip.TipText = @'
Quickly create a temporary file by using the New-TemporaryFile command, or the GetTempFileName() .NET function.

This is handy when you want save data to a temporary log file and not worry about path/permissions/filename. The temporary file will be created in "C:\Users\USER\AppData\Local\Temp\1\some-tmp.tmp".
'@
$tip.Example = @'
# Create temp file and get the path to it using the .NET class.
[string] $tmpFile = [System.IO.Path]::GetTempFileName()

# Or use the native PowerShell cmdlet instead, which returns a full FileInfo object.
[System.IO.FileInfo] $tmpFile = New-TemporaryFile

# Easily write/read/remove the temp file.
"Some data to be saved" | Out-File $tmpFile

# Cleanup when you no longer need it.
Remove-Item $tmpFile
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-temporaryfile'
	'https://learn.microsoft.com/en-us/dotnet/api/system.io.path.gettempfilename#system-io-path-gettempfilename'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Manjunath Beli (belibug)'

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
