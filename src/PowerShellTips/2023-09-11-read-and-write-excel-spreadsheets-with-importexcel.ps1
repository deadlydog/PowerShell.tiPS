$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-11')
$tip.Title = 'Read and write Excel spreadsheets with ImportExcel'
$tip.TipText = @'
Need to share large data sets with colleagues or your boss? Excel is still a popular way to do that. ImportExcel is a PowerShell module that makes it easy to read and write Excel spreadsheets. Use it to export your data to Excel, and even add charts and pivot tables. It's fast and doesn't require Excel to be installed on your computer. It's also cross-platform, so you can use it on Windows, macOS, and Linux.
'@
$tip.Example = @'
[PSCustomObject[]] $data = @(
	[PSCustomObject] @{
		FirstName = 'John'
		LastName = 'Doe'
		Age = 42
	}
	[PSCustomObject] @{
		FirstName = 'Jane'
		LastName = 'Doe'
		Age = 39
	}
)
$data | Export-Excel -Path 'C:\Temp\Results.xlsx' -WorksheetName 'People' -FreezeTopRow -AutoFilter -AutoSize
'@
$tip.Urls = @(
	'https://www.powershellgallery.com/packages/ImportExcel'
	'https://github.com/dfinke/ImportExcel'
)
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.
