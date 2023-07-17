[Tip] $tip = [Tip]::new()
{
	Id = 'StrictMode'
	Title = 'Set Strict Mode on your scripts',
	TipText = 'Enforce coding rules and raise errors for common coding mistakes by declaring strict mode at the top of your scripts.',
	Example = 'Set-StrictMode -Version Latest'
	Urls = @('https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/set-strictmode')
	MinPowerShellVersion = [Version]::new(0, 0)
	Tags = @([Tips]::Syntax)
}
$Tips.Add($tip.Id, $tip)
