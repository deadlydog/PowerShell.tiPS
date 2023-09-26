function InitializeModule
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-Debug 'Reading in configuration from JSON file and storing it in a $TiPSConfiguration variable for access by other module functions.'
	[tiPS.Configuration] $config = ReadConfigurationFromFileOrDefault
	New-Variable -Name 'TiPSConfiguration' -Value $config -Scope Script

	Write-Debug 'Reading all tips from JSON file and storing them in a $UnshownTips variable for access by other module functions.'
	[hashtable] $tipHashTable = ReadAllPowerShellTipsFromJsonFile
	New-Variable -Name 'UnshownTips' -Value $tipHashtable -Scope Script

	Write-Debug 'Removing tips that have already been shown from the $UnshownTips variable.'
	RemoveTipsAlreadyShown -Tips $script:UnshownTips

	Write-Debug "Checking if we should write a PowerShell tip, and writing one if needed."
	WriteAutomaticPowerShellTipIfNeeded -Config $script:TiPSConfiguration

	Write-Debug 'Checking if the module needs to be updated, and updating it if needed.'
	StartModuleUpdateIfNeeded -Config $script:TiPSConfiguration
}
