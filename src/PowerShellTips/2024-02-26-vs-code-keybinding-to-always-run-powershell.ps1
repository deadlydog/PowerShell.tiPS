$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-02-26')
$tip.Title = 'VS Code keybinding to always run PowerShell'
$tip.TipText = @'
VS Code is the preferred IDE to write and run PowerShell scripts. If the workspace has a .vscode\launch.json file configured though, pressing F5 may run the application instead of running the PowerShell script that you have in focus. To force VS Code to always run the PowerShell script in focus, you can add a keyboard shortcut to the keybindings.json file.

To add the keybinding, press Ctrl+Shift+P to open the Command Palette, open "Preferences: Open Keyboard Shortcuts (JSON)", and then add the following JSON to the keybindings.json file:

{
    "key": "f5",
    "command": "PowerShell.Debug.Start",
    "when": "editorTextFocus && debugState == 'inactive' && editorLangId == 'powershell'"
}
'@
$tip.Example = ''
$tip.Urls = @(
	'https://coryknox.dev/posts/2024/run-powershell-no-mater-what/'
	'https://twitter.com/CoryKnox/status/1762253942753493451'
)
$tip.Category = [tiPS.TipCategory]::Editor # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.
$tip.Author = 'Daniel Schroeder (deadlydog)'

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
