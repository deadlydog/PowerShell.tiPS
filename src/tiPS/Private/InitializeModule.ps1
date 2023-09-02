function InitializeModule
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-Debug 'Reading all tips from JSON file and storing them in a $Tips variable for access by other module functions.'
	[hashtable] $tipHashTable = ReadAllPowerShellTipsFromJsonFile
	New-Variable -Name 'Tips' -Value $tipHashtable -Option Constant -Scope Script

	Write-Debug 'Reading in configuration from JSON file and storing it in a $TiPSConfiguration variable for access by other module functions.'
	[tiPS.Configuration] $config = ReadConfigurationFromFile
	New-Variable -Name 'TiPSConfiguration' -Value $config -Scope Script

	Write-Debug 'Checking if the module needs to be updated, and updating it if needed.'
	StartModuleUpdateIfNeeded -Config $script:TiPSConfiguration
}
