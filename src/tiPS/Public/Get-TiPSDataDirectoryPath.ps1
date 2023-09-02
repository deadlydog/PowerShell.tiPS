function Get-TiPSDataDirectoryPath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $appDataDirectoryPath = GetApplicationDataDirectoryPath
	return $appDataDirectoryPath
}
