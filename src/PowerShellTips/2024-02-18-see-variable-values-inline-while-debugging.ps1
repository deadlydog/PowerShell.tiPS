$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-02-18')
$tip.Title = 'See variable values inline while debugging'
$tip.TipText = @'
The Visual Studio Code extension "Inline Values support for PowerShell" by Tyler Leonhardt is great. While you are debugging and stepping through your PowerShell code, it shows the values of variables inline in the editor.

Without this extension, to see a variable's value you would need to hover your mouse over the variable, type it into your debug prompt,look for it in the Locals debug pane, or add it to the Watch list debug pane. Being able to see the variable values without having to take any additional steps is a huge time saver and makes debugging much easier.

If you try the extension and love it, show your appreciation by giving it a rating and review on the Visual Studio Code Marketplace.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://marketplace.visualstudio.com/items?itemName=TylerLeonhardt.vscode-inline-values-powershell'
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
