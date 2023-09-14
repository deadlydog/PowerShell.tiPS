function Get-TiPSConfiguration
{
<#
	.SYNOPSIS
	Get the tiPS module configuration for the current user.

	.DESCRIPTION
	Get the tiPS module configuration for the current user.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	A [tiPS.Configuration] object containing all of the tiPS module configuration for the current user.

	.EXAMPLE
	Get-TiPSConfiguration

	Get the tiPS module configuration.
#>

	[CmdletBinding()]
	[OutputType([tiPS.Configuration])]
	Param()

	return $script:TiPSConfiguration
}
