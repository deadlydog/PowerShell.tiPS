$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-07-17')
$tip.Title = 'Set Strict Mode on your scripts'
$tip.TipText = 'Enforce coding rules and raise errors for common coding mistakes by declaring strict mode at the top of your scripts.'
$tip.Example = 'Set-StrictMode -Version Latest'
$tip.Urls = @('https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode')
$tip.MinPowerShellVersion = '0.0'
$tip.Category = [tiPS.TipCategory]::Syntax
