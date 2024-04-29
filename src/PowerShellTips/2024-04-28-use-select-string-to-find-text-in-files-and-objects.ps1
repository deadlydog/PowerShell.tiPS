$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-04-28')
$tip.Title = 'Use Select-String to find text in files and objects'
$tip.TipText = @'
The Select-String cmdlet works similar to grep and searches for the specified text in files or objects. By default it will use a regular expression pattern to search, but you can provide the -SimpleMatch parameter to do a basic text compare instead. The -Path parameter accepts wildcards and can be used to search multiple files at once. You can also pipe objects to Select-String to search them instead of files.

When searching files, Select-String will return the filename and line number where the match was found. When searching objects, it will return the object itself. You can also use the -Context parameter to return surrounding lines of text for each match.
'@
$tip.Example = @'
# Search log files for errors and warnings.
Select-String -Pattern 'error','warning' -Path 'C:\temp\log\*.log'

# Use -NotMatch to find lines that don't match the pattern, showing 2 lines before and 3 lines after the match.
Select-String -Pattern 'success' -Path 'C:\temp\log\*.log' -NotMatch -Context 2,3

# Search objects and arrays for text. This uses a case-sensitive basic text compare.
'Hello.', 'HELLO.', 'HELLO!' | Select-String -Pattern 'HELLO.' -CaseSensitive -SimpleMatch

# Search using regular expressions.
'bat', 'batman', 'sabbatical', 'take a bath' | Select-String -Pattern 'bat.+'

# Search through Windows Event Logs for events containing the word 'Failed'.
$events = Get-WinEvent -LogName Application -MaxEvents 50
$events | Select-String -InputObject { $_.message } -Pattern 'Failed'

# If you need to search files in subdirectories too, use Get-ChildItem and the -Recurse parameter.
Get-ChildItem -Path "C:\temp" -Recurse -Include '*.log' | Select-String -Pattern "error"
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string'
	'https://lazyadmin.nl/powershell/powershell-grep-select-string/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.

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
