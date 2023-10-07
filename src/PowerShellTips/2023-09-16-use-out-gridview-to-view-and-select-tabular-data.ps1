$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-16')
$tip.Title = 'Use Out-GridView to view and select tabular data'
$tip.TipText = @'
Instead of piping data to Out-Table, use Out-GridView. This opens a window with the data in a grid view, allowing you to interactively sort and filter the data. If you provide the -PassThru parameter, you can select one or more rows and the selected data will be returned to the pipeline, allowing you to save it to a variable or pipe it to other commands.

NOTE: Out-GridView is only available on Windows.
'@
$tip.Example = 'Get-Process | Out-GridView -PassThru -Title "Select processes to return" | Select-Object -Property ProcessName,Id'
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-gridview'
	'https://woshub.com/using-out-gridview-table-powershell/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
