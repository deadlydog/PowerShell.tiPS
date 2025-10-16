$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-16')
$tip.Title = 'Use -join to make regex more readable'
$tip.TipText = @'
Regular expressions can be hard to read when you see the entire pattern in one long string. You can use a string array with the -join operator to break the pattern into multiple lines, making it easier to read and understand. This also allows you to comment each part of the regex pattern.
'@
$tip.Example = @'
[string] $emailAddressRegexPattern = @(
    '(?<localPart>[^\s]+)' # Local part of the email address (before the @ symbol).
    '@'                    # The @ symbol.
    '(?<domain>[^@]+)'     # Domain part of the email address.
    '(?<tld>\.[a-z]{2,})'  # Top-level domain (e.g. .com, .org, .net).
) -join ''
# Creates the string: (?<localPart>[^\s]+)@(?<domain>[^@]+)(?<tld>\.[a-z]{2,})

# Can also use -join to concatenate strings in more complex ways.
[string] $concatenatedString = @(
    'This is'
    'a concatenated string'
    'with numbers 1 - 10:'
    1..10 | ForEach-Object { $_ }
    @(
        '. And more'
        'nested strings'
    ) -join ' '
) -join ' '
# Creates the string: This is a concatenated string with numbers 1 - 10: 1 2 3 4 5 6 7 8 9 10 . And more nested strings
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_join'
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
