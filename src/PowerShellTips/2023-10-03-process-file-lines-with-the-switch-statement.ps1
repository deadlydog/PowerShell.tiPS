$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-03')
$tip.Title = 'Process file lines with the switch statement'
$tip.TipText = @'
While the switch statement is typically used to evaluate a single value, it can also be used to evaluate arrays. By using the -File parameter with the switch statement, it will treat each line of the file as an array item, allowing you to process a text file line-by-line and take actions when a specific value is found. You can use the typical switch parameters to match on exact text, wildcards, or regular expressions.
'@
$tip.Example = @'
# Output the file contents to the console, converting error lines to errors, and warning lines to warnings.
switch -Wildcard -File $path
{
    'Error*'
    {
        Write-Error -Message $PSItem
    }
    'Warning*'
    {
        Write-Warning -Message $PSItem
    }
    default
    {
        Write-Output $PSItem
    }
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-switch#-file'
	'https://twitter.com/dfinke/status/1698733677285388581'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
