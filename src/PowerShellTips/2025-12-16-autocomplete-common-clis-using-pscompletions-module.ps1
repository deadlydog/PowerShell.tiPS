$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-12-16')
$tip.Title = 'Autocomplete common CLIs using PSCompletions module'
$tip.TipText = @'
Similar to how the PoshGit module provides tab completion for Git commands, the PSCompletions (psc) module offers autocompletion for a variety of widely-used command-line interfaces (CLIs). This includes tools like 7-zip, Bun, Chocolatey, Docker, Git, Kubernetes (kubectl), NGrok, Node, NPM, NVM, Oh-My-Posh, PowerShell, Pwsh, Python, Scoop, WinGet, WSL, Windows Terminal, Yarn, and many others. Use the command `psc add <tool>` to enable autocompletion for a specific CLI.

The module also offers a different tab-completion experience for PowerShell, with more of a TUI (Text User Interface) feel. It supports filtering as you type, as well as wildcard matching. If you want the autocompletion, but not the new tab-completion experience, you can disable it with `psc menu config enable_menu 0`.

In order for the autocompletion to work, you must first import the PSCompletions module, so you will want to add it to your $Profile script.
'@
$tip.Example = @'
# One-time setup: First install the module, then add autocompletion for common CLIs you use.
Install-Module -Name PSCompletions -Scope CurrentUser
psc add <tab> # Show the list of available CLIs to add autocompletion for.
psc add git
psc add docker
psc add kubectl

# Ensure the module is imported for autocompletion to work (add this to your $Profile).
Import-Module PSCompletions

# See the CLI autocompletion for docker and git in action.
docker <tab>
git stash <tab>

# Disable the TUI tab completion menu if you prefer the default PowerShell experience (set to 1 to enable).
psc menu config enable_menu 0
'@
$tip.Urls = @(
	'https://pscompletions.abgox.com'
	'https://github.com/abgox/PSCompletions'
	'https://github.com/abgox/PSCompletions/blob/main/completions.md'
)
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
