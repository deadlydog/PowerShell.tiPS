[Tip] $tip = [Tip]::new()
$tip.Id = 'PowerShellIsOpenSource'
$tip.Title = 'PowerShell is open source'
$tip.TipText = 'Did you know that PowerShell is open source? You can contribute to the project on GitHub.'
$tip.Example = 'Example code to demonstrate the tip.'
$tip.Urls = @('https://github.com/PowerShell/PowerShell')
$tip.MinPowerShellVersion = [Version]::new(0, 0)
$tip.Tags = @()

$Tips.Add($tip.Id, $tip)
