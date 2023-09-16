if (-not ('tiPS.PowerShellTip' -as [type]))
{
	# This script may be called from a Pester test or an internal tool, where the PSModuleRoot variable
	# may not be set, so fallback to using PSScriptRoot in those cases.
	[string] $assemblyFilePath = [string]::Empty
	if (Test-Path -Path variable:script:PSModuleRoot)
	{
		$assemblyFilePath = Resolve-Path -Path "$script:PSModuleRoot/Classes/tiPSClasses.dll"
	}
	else
	{
		$assemblyFilePath = Resolve-Path -Path "$PSScriptRoot/tiPSClasses.dll"
	}
	Add-Type -Path $assemblyFilePath
}
