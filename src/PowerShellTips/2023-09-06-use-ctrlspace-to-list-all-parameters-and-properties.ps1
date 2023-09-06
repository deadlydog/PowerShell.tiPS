$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-06')
$tip.Title = 'Use Ctrl+Space to list all parameters, properties, and possibilities'
$tip.TipText = @'
In the terminal, when you are typing a command, parameter, or property, press Ctrl+Space to see a list of all the possible options. If there is only a single option, it will auto-complete the command, parameter, or property for you. If there are many options, it will list them all for you to choose from, and you use the arrow keys to navigate the list and select one.

For example, if you type `Get-Process -` and then press Ctrl+Space, you will see all the possible parameters you can use with the `Get-Process` command.

If you have a variable, you can type `$variableName.` and then press Ctrl+Space to see all the properties and methods for the variable.

It will even autocomplete partial commands, variables, properties, and methods. If you type `Get-Pro` and press Ctrl+Space, it will list all the commands that start with `Get-Pro`, including their parameter sets.

Similarly, if you have the variables `$variable1` and `$variable2`, you can type `$var` and press Ctrl+Space to see all the variables that start with `$var`, including their type if available (e.g. [string], [int]).

Ctrl+Space is similar to using tab completion except it will show you all of the options, instead of just one option at a time and having to tab cycle through them.

Note: Requires the `PSReadLine` module, which is included in PowerShell 5.1 and newer.
'@
$tip.Example = 'Get-Process -<Ctrl+Space>'
$tip.Urls = @('https://blog.danskingdom.com/PowerShell-intellisense-on-the-command-line/')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Terminal # Community, Editor, Module, Syntax, Terminal, or Other.
