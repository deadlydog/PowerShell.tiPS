$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-11')
$tip.Title = 'Create test files of arbitrary size'
$tip.TipText = @'
When doing performance testing it can be useful to have a file of a specific size to test with. Creating files of a specific size is fairly straightforward with the System.IO.FileStream class.
'@
$tip.Example = @'
[string] $fileName = [System.IO.Path]::GetRandomFileName()
[string] $filePath = Join-Path -Path (Get-Location) -ChildPath $fileName
[int64] $fileSize = 10MB

try {
    $tempFile = [System.IO.FileStream]::new($filePath, Create, ReadWrite)
    $tempFile.SetLength($fileSize)
    $tempFile.Close()

    Write-Output 'Created the following temp file:'
    Get-ChildItem $filePath | Select-Object FullName,DirectoryName,Name,Length,CreationTime
} catch {
    Write-Error $_
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.io.filestream'
	'https://claytonerrington.com/blog/creating-a-test-file'
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
