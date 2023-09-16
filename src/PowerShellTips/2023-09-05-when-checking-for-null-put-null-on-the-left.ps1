$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-05')
$tip.Title = 'When checking for $null, put $null on the left'
$tip.TipText = @'
When checking if a variable or expression is null, put the $null on the left side of the comparison.

If the variable you are checking is an array that contains a null value, the comparison may not return the expected result if you put the $null on the right side of the comparison.

Do this: if ($null -eq $variable)
Not this: if ($variable -eq $null)
'@
$tip.Example = 'if ($null -eq $variable) { "The variable really is null." }'
$tip.Urls = @(
	'https://powershellexplained.com/2018-12-23-Powershell-null-everything-you-wanted-to-know/'
	'https://stackoverflow.com/a/60996703/602585'
)
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Syntax # Community, CoreCmdlet, Editor, Module, Syntax, Terminal, or Other.
