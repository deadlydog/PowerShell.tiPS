$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-21')
$tip.Title = 'Use Here-strings for hardcoded multiline strings'
$tip.TipText = @'
When you are defining multiline strings in code, you could create a string and use `r`n or [Environment]::NewLine to create new lines in it. If it is a long string, you may even choose to break it into multiple lines in code and concatenate them using the + operator. However, this can be cumbersome to both write and read. Instead, you can use a here-string to define a multiline string.

A here-string is a string that is defined between two `@ symbols. The here-string can be defined with single or double quotes. If you use single quotes, the string will be a literal string and no variable expansion will occur. If you use double quotes, variable expansion will occur.

Here-strings allow you to define and see a multiline string in your code exactly as it will appear when it is output.
'@
$tip.Example = @'
[string] $multilineString = @'
This is the first line of the string.
This is the second line of the string.

  There is a blank line above this line, and 2 spaces at the start of this line.
This $variable will not be expanded because we used single quotes.
`'@

[int] $johnDoeAge = 42
[string] $jsonString = @"
{
    "Name": "John Doe",
    "Age": $johnDoeAge
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_quoting_rules#here-strings'
	'https://devblogs.microsoft.com/scripting/maximizing-the-power-of-here-string-in-powershell-for-configuration-data'

)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.
