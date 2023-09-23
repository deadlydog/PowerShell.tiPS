$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-23')
$tip.Title = 'Use $PSVersionTable to get PowerShell session info'
$tip.TipText = @'
The $PSVersionTable automatic variable contains information about the current PowerShell session, including the PowerShell version, operating system, and more.
'@
$tip.Example = @'
Write-Output "The PowerShell version being used is $($PSVersionTable.PSVersion)"

Write-Output "Below is the full contents of the `$PSVersionTable variable:"
$PSVersionTable
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables#psversiontable'
)
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.
