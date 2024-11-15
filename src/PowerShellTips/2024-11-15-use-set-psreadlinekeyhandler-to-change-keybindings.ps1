$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-11-15')
$tip.Title = 'Use Set-PSReadLineKeyHandler to change keybindings'
$tip.TipText = @'
You can use the Set-PSReadLineKeyHandler cmdlet to change key bindings.

A handy shortcut to set is for AcceptNextSuggestionWord which is built within ForwardWord function. This function is bound to the key chord Ctrl + F on Unix but not on Windows. The following is a way to enable that mapping on Windows.
'@
$tip.Example = @'
# With the following example you will be able to set the Ctrl+f to accept the next word of an inline suggestion.
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord

# You could change the Right arrow to accept the next word instead of the whole suggestion line.
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.4#changing-keybindings'
	'https://learn.microsoft.com/en-us/powershell/module/psreadline/set-psreadlinekeyhandler?view=powershell-7.4'
)
$tip.Category = [tiPS.TipCategory]::Terminal # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Adrian Muscat (adrimus)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
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
