$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-05-05')
$tip.Title = 'Use Join-Path and Split-Path to create cross-platform paths'
$tip.TipText = @'
When creating file paths in PowerShell, use the `Join-Path` cmdlet instead of string concatenation. This ensures that the correct path separator is used for the current platform (e.g. `\` on Windows and `/` on Linux/macOS). PowerShell 6 introduced the -AdditionalChildPath parameter, which allows you to specify multiple child paths to join.

Similarly, you can use the `Split-Path` cmdlet to split a path into its components. This is useful for extracting the directory or file name from a full path.
'@
$tip.Example = @'
# Don't do this, as it may not work on all platforms.
[string] $configFilePath = "$HOME\Config\config.json"

# Do this instead, as it works on all platforms.
[string] $configDirectoryPath = Join-Path -Path $HOME -ChildPath 'Config'
[string] $configFilePath = Join-Path $configDirectoryPath 'config.json' # Excludes -Path and -ChildPath for brevity.

# In PowerShell 6+ you can join multiple child paths at once.
[string] $configFilePath = Join-Path -Path $HOME -AdditionalChildPath 'Config' 'config.json'
[string] $xmlFilePath = Join-Path $HOME 'Config' 'config.xml' # Excludes parameter names for brevity.

# Use -Resolve to ensure we get an absolute path, and error if the path does not exist.
[string] $configFilePath = Join-Path $HOME 'Config' 'config.json' -Resolve

# Get the name of the file with and without the extension, it's parent directory path, and it's parent directory name.
[string] $fileName = Split-Path -Path $configFilePath -Leaf
[string] $fileNameWithoutExtension = Split-Path -Path $configFilePath -LeafBase
[string] $directoryPath = Split-Path -Path $configFilePath -Parent
[string] $directoryName = Split-Path -Path $directoryPath -Leaf

# Change the working directory to the folder containing your PowerShell profile.
Set-Location (Split-Path -Path $PROFILE)
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/join-path'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path'
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
