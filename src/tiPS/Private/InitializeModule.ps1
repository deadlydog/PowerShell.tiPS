function InitializeModule
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-Debug 'Reading all tips from JSON file and storing them in a $Tips variable for access by other module functions.'
	[hashtable] $tipHashTable = ReadAllPowerShellTipsFromJsonFile
	New-Variable -Name 'Tips' -Value $tipHashtable -Option Constant -Scope Script

	Write-Debug 'Reading in configuration from JSON file and storing it in a $TiPSConfiguration variable for access by other module functions.'
	[tiPS.Configuration] $config = ReadConfigurationFromFileOrDefault
	New-Variable -Name 'TiPSConfiguration' -Value $config -Scope Script

	Write-Debug 'Removing tips that have already been seen from the $Tips variable.'
	RemoveTipsAlreadySeen -Tips $script:Tips

	Write-Debug "Checking if we should write a PowerShell tip, and writing one if needed."
	WriteAutomaticPowerShellTipIfNeeded -Config $script:TiPSConfiguration

	Write-Debug 'Checking if the module needs to be updated, and updating it if needed.'
	StartModuleUpdateIfNeeded -Config $script:TiPSConfiguration
}
