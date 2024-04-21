$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-11-05')
$tip.Title = 'Get and Set the clipboard contents'
$tip.TipText = @'
You can capture the contents of the clipboard to a variable with the Get-Clipboard command. Similarly, you can set the contents of the clipboard with the Set-Clipboard command. This is useful for automating interactive tasks that involve the user copying and pasting text or files.
'@
$tip.Example = @'
# Capture the contents of the clipboard to a variable.
Read-Host -Prompt "Copy all of the files you want to rename to the clipboard, then press Enter."
$filesToRename = Get-Clipboard

$renamedFiles = SomeFunctionToRenameFiles $filesToRename

# Set the contents of the clipboard to the renamed files.
$renamedFiles | Set-Clipboard
Write-Host "The renamed files are now on the clipboard, ready for you to paste somewhere else."
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-clipboard'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard'
	'https://adamtheautomator.com/powershell-copy-to-clipboard/'
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
