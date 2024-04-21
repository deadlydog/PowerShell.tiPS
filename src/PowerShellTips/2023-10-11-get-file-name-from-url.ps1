$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-11')
$tip.Title = 'Get file name from URL'
$tip.TipText = @'
If you have a URL that contains a path to a file, you can use the [URI] class to extract the file path and name.
'@
$tip.Example = @'
PS> [URI] $uri = 'https://some-server.com/Path/To/File.txt?someQueryParameter=123#Heading1'

PS> $uri
AbsolutePath   : /Path/To/File.txt
AbsoluteUri    : https://some-server.com/Path/To/File.txt?someQueryParameter=123#Heading1
PathAndQuery   : /Path/To/File.txt?someQueryParameter=123
Segments       : {/, Path/, To/, File.txt}
Host           : some-server.com
Port           : 443
Query          : ?someQueryParameter=123
Fragment       : #Heading1
Scheme         : https

PS> Split-Path -Path $uri.AbsolutePath -Leaf
File.txt

PS> Split-Path -Path $uri.AbsolutePath -LeafBase
File
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.uri'
	'https://twitter.com/devopsjeremy/status/1709773064563744888?s=46&t=-Ox1iPV67-4Vqb8wIZ275A'
)
$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
