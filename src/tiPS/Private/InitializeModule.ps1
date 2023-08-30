function InitializeModule
{
	[CmdletBinding()]
	Param()

	Write-Debug 'Reading all tips from JSON file and storing them in a $Tips variable for access by other module functions.'
	[hashtable] $tipHashTable = ReadAllPowerShellTipsFromJsonFile
	New-Variable -Name 'Tips' -Value $tipHashtable -Option Constant -Scope Script

	Write-Debug 'Reading in configuration from JSON file and storing it in a $TipsConfiguration variable for access by other module functions.'
	[tiPS.Configuration] $config = ReadConfigurationFromFile
	New-Variable -Name 'TipsConfiguration' -Value $config -Scope Script
}
