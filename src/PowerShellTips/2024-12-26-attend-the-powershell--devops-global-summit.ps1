$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-12-26')
$tip.Title = 'Attend the PowerShell + DevOps Global Summit'
$tip.TipText = @'
The PowerShell + DevOps Global Summit happens every year somewhere in the United States, usually in April. The conference is a great place to learn about PowerShell and DevOps, and to meet and network with other people in the PowerShell community, including Microsoft MVPs and the Microsoft PowerShell team. Discuss the latest trends, best practices, and tips and tricks with other PowerShell enthusiasts!

Want to speak at the conference? The call for speakers is typically open during October and November, where you can submit your session ideas for consideration. Speakers often receive a free ticket to the conference and sometimes additional reimbursement. It's a great opportunity to share your knowledge with the community.

Check the website for the latest information on the conference dates, location, sessions, and registration details.
'@
$tip.Example = 'Start-Process https://www.powershellsummit.org'
$tip.Urls = @(
	'https://www.powershellsummit.org'
)
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
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
