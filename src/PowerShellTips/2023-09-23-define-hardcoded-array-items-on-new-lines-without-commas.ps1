$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-23')
$tip.Title = 'Define hardcoded array items on new lines without commas'
$tip.TipText = @'
When defining hardcoded arrays with many values in PowerShell, you can define each item on a new line without commas; the commas are optional. This makes it easier to read and maintain the array items, and you don't have to worry about commas when adding or rearranging items.

If you choose to define multiple array values on a single line, then you will need a comma between each item on the line.
'@
$tip.Example = @'
[string[]] $stringArray = @(
    'Notice that each item is on a new line without commas.'
    'This is much easier to read and maintain.'
    'And you can add comments to explain each item if needed.' # Like this.
)

[int[]] $intArray = @(1, 2, 3)
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.3#create-an-array'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
