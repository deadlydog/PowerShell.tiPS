$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-21')
$tip.Title = 'Use PSBoundParameters to check if a parameter was provided'
$tip.TipText = @'
When writing a function you may want to check if a parameter was provided by the caller. With reference types (e.g. [string]) you can simply check if the parameter is null, but what is $null is a valid value for the parameter and you need to take different action if the parameter was not provided? Similarly, what if the parameter is a value type (e.g. [int]) and you need to take action if the caller provided the default value (e.g. zero), but not if they didn't provide the parameter?

You can check if a parameter was passed to a script/function by using the $PSBoundParameters automatic variable. This variable contains a hashtable of all parameters that were passed to the function, and you can use the ContainsKey function to check if a specific parameter was passed.
'@
$tip.Example = @'
function Test-ParameterWasPassed([string] $OptionalParameter = $null)
{
	if ($PSBoundParameters.ContainsKey('OptionalParameter'))
	{
		Write-Output 'OptionalParameter was passed.'
	}
	else
	{
		Write-Output 'OptionalParameter was not passed.'
	}
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables#psboundparameters'
	'https://devblogs.microsoft.com/powershell/checking-for-bound-parameters/'
	'https://www.reza-aghaei.com/how-to-determine-if-a-parameter-is-passed-to-a-powershell-cmdlet/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
