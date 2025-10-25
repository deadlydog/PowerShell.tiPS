$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-24')
$tip.Title = 'Use Join-Path for cross-platform compatible paths'
$tip.TipText = @'
When constructing file system paths in PowerShell, especially in scripts that may run on different operating systems (like Windows, Linux, or macOS), it's best to use the `Join-Path` cmdlet instead of string concatenation. This cmdlet automatically uses the correct path separator ('/' or '\') for the operating system, ensuring that your paths are constructed correctly regardless of where the script is executed. You can also use the `-Resolve` parameter to ensure that the constructed path exists, which can help prevent errors when accessing files or directories.

As of PowerShell 6 and later, Join-Path accepts multiple path segments, allowing you to provide and combine many child path segments in a single call.
'@
$tip.Example = @'
# Basic example to access 'C:\Temp\File.txt'.
Join-Path -Path 'C:\Temp' -ChildPath 'File.txt'

# Shorthand syntax.
Join-Path 'C:\Temp' 'File.txt'

# PowerShell 6+ example with multiple segments, to access 'C:\Temp\TempFolder\ASubFolder\AnotherSubFolder\TempFile.txt'.
Join-Path -Path 'C:\Temp' -ChildPath 'TempFolder' -AdditionalChildPath 'ASubFolder', 'AnotherSubFolder', 'TempFile.txt'

# Shorthand syntax with multiple segments.
Join-Path 'C:\Temp' 'TempFolder', 'ASubFolder', 'AnotherSubFolder', 'TempFile.txt'

# Return multiple paths on different drives.
Join-Path -Path 'C:', 'D:', 'E:' -ChildPath 'TempFile.txt'

# Potentially return multiple paths using wildcards and -Resolve. (e.g. returns C:\Users\Alice\Desktop, C:\Users\Bob\Desktop, etc.)
Join-Path -Path 'C:\Users\*' -ChildPath 'Desktop' -Resolve

# Use the -Resolve parameter to ensure the path exists (throws exception if it doesn't).
Join-Path -Path '/usr/local' -ChildPath 'bin' -AdditionalChildPath 'script.sh' -Resolve
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/join-path'
	'https://x.com/adbertram/status/1782005562286252241?s=46&t=-Ox1iPV67-4Vqb8wIZ275A'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
