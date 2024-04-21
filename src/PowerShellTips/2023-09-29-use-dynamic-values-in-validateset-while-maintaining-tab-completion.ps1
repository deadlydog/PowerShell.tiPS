$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-29')
$tip.Title = 'Use dynamic values in ValidateSet while maintaining tab completion'
$tip.TipText = @'
The ValidateSet attribute is a great way to limit the values that can be passed to a parameter, and it provides tab autocompletion for the parameter values. Typically if you wanted to use dynamic values you would use the ValidateScript attribute instead, but then you lose the tab autocompletion.

A way to get the best of both worlds is to create a class that implements the System.Management.Automation.IValidateSetValuesGenerator interface. This interface has a single method, GetValidValues(), that returns an array of strings. You can put the logic to dynamically retrieve your allowed parameter values in the GetValidValues() method. You can then use the ValidateSet attribute with the type of your class, and the tab autocompletion will work as expected.
'@
$tip.Example = @'
class AllowedParameterValues : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        # Populate these values dynamically by querying a database, reading a file, calling an API, etc.
        $values = @('Value1', 'Value2', 'Value3')
        return $values
    }
}

function Test-ValidateSet {
    param (
        [ValidateSet([AllowedParameterValues])]
        [string] $Value
    )
    return $Value
}

Test-ValidateSet -Value # Tab complete here to see the dynamic values.
'@
$tip.Urls = @(
	'https://www.linkedin.com/feed/update/urn:li:activity:7113300637735407618/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'
