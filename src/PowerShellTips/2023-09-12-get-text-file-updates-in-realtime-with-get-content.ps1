$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-12')
$tip.Title = 'Get text file updates in realtime with Get-Content'
$tip.TipText = @'
Get-Content provides a `-Wait` switch that can be used to get updates to a text file in realtime. This is useful for monitoring log files from the terminal, or any other text file that is updated over time.

In addition, if you want to get the last N lines of a file, you can use the `-Tail` parameter. This is useful for getting only the last few lines of a very large text file.

Once you are done monitoring the file, you can press `Ctrl+C` to stop the command.
'@
$tip.Example = 'Get-Content -Path $filePath -Wait -Tail 10'
$tip.Urls = @('https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content', 'https://4sysops.com/archives/parse-log-files-with-powershell/')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::CoreCmdlet # Community, CoreCmdlet, Editor, Module, Syntax, Terminal, or Other.
