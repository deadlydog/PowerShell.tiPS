function Get-TiPSConfiguration
{
	[CmdletBinding()]
	[OutputType([tiPS.Configuration])]
	Param()

	return $script:TiPSConfiguration
}
