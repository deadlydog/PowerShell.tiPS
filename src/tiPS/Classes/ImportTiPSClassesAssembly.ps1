if (-not ('tiPS.PowerShellTip' -as [type]))
{
	$assemblyFilePath = Resolve-Path -Path "$script:PSModuleRoot/Classes/tiPSClasses.dll"
	Add-Type -Path $assemblyFilePath
}
