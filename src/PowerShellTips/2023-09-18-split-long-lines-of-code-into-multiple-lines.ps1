$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-18')
$tip.Title = 'Split long lines of code into multiple lines'
$tip.TipText = @'
Long lines of code can be difficult to read, especially when doing code reviews in a web browser and for users not using word-wrap in their editors. It is good practice to try and avoid long lines of code.

PowerShell lines can naturally be split into multiple lines at many operators, such as =, +, -, |, {, -eq, etc.

If you need to split a line at an unnatural location, you can use the backtick character (`) at the end of each line. This is generally discouraged though as the backtick can be hard to see, easy to forget, and a space after the backtick breaks the line continuation. However, there are times when it may still be useful.
'@
$tip.Example = @'
# Split into multiple lines using natural operators.
[bool] $arrayIsNullOrEmpty =
    $null -eq $myIntegerArray -or
    $myIntegerArray.Length -eq 0

[int[]] $valuesGreaterThan10AndSorted =
    $myIntegerArray |
    Where-Object {
        $_ -gt 10
    } |
    Sort-Object

[string] $myString =
    'This is a very long string that is split into multiple lines ' +
    'using the + operator.'

# Split into multiple lines at an unnatural locations using the backtick.
Get-ChildItem `
    -Path 'C:\' `
    -Recurse `
    -File `
    -Filter '*.txt'
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parsing?view=powershell-7.3#line-continuation'
)
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.
