$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-21')
$tip.Title = 'Get the .NET version your code is running on'
$tip.TipText = @'
.NET has a FrameworkDescription property that returns the version of .NET your code is running on. This is useful if you want to write code that behaves differently depending on the version of .NET it's running on, or when troubleshooting issues that users may be experiencing.
'@
$tip.Example = @'
# Running the command on PowerShell 7.
> [System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
.NET 7.0.11

# Running the command on PowerShell 5.1.
> [System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
.NET Framework 4.8.4644.0
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.runtimeinformation.frameworkdescription'
	'https://twitter.com/JeffHicks/status/1705007619499237525'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
