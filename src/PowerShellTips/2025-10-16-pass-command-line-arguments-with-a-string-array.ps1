$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-16')
$tip.Title = 'Pass command-line arguments with a string array'
$tip.TipText = @'
If you need to call an executable from PowerShell and pass command-line arguments, you can use a string array to hold the arguments. This is especially useful when the arguments contain spaces or special characters, as it helps avoid issues with quoting and escaping. Each element in the array represents a separate argument, and PowerShell will handle the proper formatting when calling the executable. This can also improve the readability of your code, and allow you to comment each argument.
'@
$tip.Example = @'
[string] $executable = 'example.exe'
[string[]] $arguments = @(
    '-arg1', 'value1'            # Argument 1 with its value.
    '-arg2', 'value with spaces' # Argument 2 with a value that contains spaces.
    '-flag'                      # A flag argument without a value.
)
& $executable $arguments

# Real-world example using ping.exe
[string] $pingExecutable = 'ping.exe'
[string[]] $pingArguments = @(
    'google.com' # Target to ping.
    '-n', '6'    # Number of echo requests to send.
    '-w', '1000' # Timeout in milliseconds.
)
& $pingExecutable $pingArguments
'@
$tip.Urls = @(
	'https://stackoverflow.com/a/39366449/602585'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
