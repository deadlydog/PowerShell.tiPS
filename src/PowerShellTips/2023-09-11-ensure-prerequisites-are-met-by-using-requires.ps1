$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-11')
$tip.Title = 'Ensure prerequisites are met by using #Requires'
$tip.TipText = @'
Use the #Requires statement to ensure that the environment meets the prerequisites for your script to run. You can use #Requires to check that:
- A minimum PowerShell version is being used
- PowerShell Desktop or PowerShell Core is being used
- Specific modules or snap-ins are installed
- The script is running as Administrator

If one of the required prerequisites are not met, PowerShell will throw an error and the script will not run.
'@
$tip.Example = @'
#Requires -Version 7.2
#Requires -PSEdition Core
#Requires -Modules @{ ModuleName="Az.KeyVault"; ModuleVersion="4.0.0" }
#Requires -RunAsAdministrator
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_requires'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'
