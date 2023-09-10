$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-06')
$tip.Title = 'Use Ctrl+Space to list all parameters, properties, and possibilities'
$tip.TipText = @'
In the terminal, when you are typing a command, parameter, or property, press Ctrl+Space to see a list of all the possible options. If there is only a single option, it will auto-complete the field for you. If there are many options, it will list them all for you to choose from and you can use the arrow keys to navigate the list and select one.

Ctrl+Space is similar to tab completion, except it will show you all of the options instead of just one option at a time and having to tab cycle through them.

Note: Requires the `PSReadLine` module, which is included in PowerShell 5.1 and newer.
'@
$tip.Example = @'
- Type `Get-Process -` and press Ctrl+Space to list all the possible parameters you can use with the `Get-Process` command.
- Type `$variableName.` and press Ctrl+Space to list all the properties and methods for the variable.
- Type `Get-Pro` and press Ctrl+Space to list all the commands that start with `Get-Pro`, including their parameter sets.
- Type part of a variable name (e.g. $var) and press Ctrl+Space to list all the variables that start with `$var`, including their type if available (e.g. [string], [int]).
'@
$tip.Urls = @('https://blog.danskingdom.com/PowerShell-intellisense-on-the-command-line/')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Terminal # Community, Editor, Module, Syntax, Terminal, or Other.
