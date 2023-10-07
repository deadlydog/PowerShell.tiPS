$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-19')
$tip.Title = 'Use Splatting for nicer code and dynamic parameters'
$tip.TipText = @'
Splatting allows you to pass parameters to a function as a hashtable. This can make your code more readable when you have a lot of parameters to pass to a function. It also allows you to build the parameters dynamically.

To use splatting, create a hashtable with the parameter names as the keys and the parameter values as the values. Then, pass the hashtable to the function using the `@` operator.

You can also use splatting with arrays, where the array values are passed to the function as positional parameters.

In a function, you can use the $PSBoundParameters automatic variable to access the parameters that were passed to the function. This allows you to modify and extend the given parameters before passing them to another function.
'@
$tip.Example = @'
$hashtableParameters = @{
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true
}
Copy-Item @hashtableParameters

$arrayParameters = "test.txt", "test2.txt"
Copy-Item @arrayParameters -WhatIf
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting'
	'https://adamtheautomator.com/powershell-splatting/'
	'https://4sysops.com/archives/use-splatting-and-psboundparameters-to-pass-parameters-in-powershell/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
