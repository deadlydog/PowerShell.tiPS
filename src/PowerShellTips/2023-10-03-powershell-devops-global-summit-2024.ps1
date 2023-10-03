$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-03')
$tip.Title = 'PowerShell DevOps Global Summit 2024'
$tip.TipText = @'
The PowerShell DevOps Global Summit will be held in Bellevue, Washington, USA from April 8 - 11, 2024. The conference is a great place to learn about PowerShell and DevOps, and to meet and network with other people in the PowerShell community.

Want to speak at the conference? The call for speakers is open from October 1 to November 15, 2023.
'@
$tip.Example = ''
$tip.Urls = @(
	'https://www.powershellsummit.org/'
	'https://sessionize.com/pshsummit24/'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
