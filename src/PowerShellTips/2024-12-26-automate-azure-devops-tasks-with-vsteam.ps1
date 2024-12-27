$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-12-26')
$tip.Title = 'Automate Azure DevOps tasks with VSTeam'
$tip.TipText = @'
Many organizations use Azure DevOps as their application lifecycle management (ALM) tool. VSTeam is a PowerShell module that provides cmdlets for many Azure DevOps tasks, which can be easier than calling the Azure DevOps APIs directly. It's a great way to simplify and automate many Azure DevOps tasks, such as retrieving and updating work items, teams, git repos, pull requests, release definitions, and more.
'@
$tip.Example = @'
# List all commits in the demo project for a specific repository.
Get-VSTeamGitCommit -ProjectName demo -RepositoryId 118C262F-0D4C-4B76-BD9B-7DD8CA12F196

# List of all agent pools.
Get-VSTeamPool

# Gets work items with IDs 47 and 48.
Get-VSTeamWorkItem -Id 47,48

# Updates the title of work item 1.
Update-VSTeamWorkItem -WorkItemId 1 -Title "Updated Work Item Title"
'@
$tip.Urls = @(
	'https://methodsandpractices.github.io/vsteam-docs/'
	'https://methodsandpractices.github.io/vsteam-docs/docs/modules/vsteam/commands/'
	'https://github.com/MethodsAndPractices/vsteam-docs'
)
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
