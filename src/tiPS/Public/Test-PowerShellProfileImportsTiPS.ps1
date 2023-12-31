function Test-PowerShellProfileImportsTiPS
{
<#
	.SYNOPSIS
	Tests whether the PowerShell profile imports the tiPS module.

	.DESCRIPTION
	Tests whether the PowerShell profile imports the tiPS module.
	Returns true if it finds an 'Import-Module -Name tiPS' statement in the profile, false otherwise.
	This only looks in the default PowerShell profile paths.
	If the tiPS module is imported from a dot-sourced file then this will return false.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	System.Boolean representing if the tiPS module is imported by the PowerShell profile or not.

	.EXAMPLE
	Test-PowerShellProfileImportsTiPS

	Tests whether the PowerShell profile imports the tiPS module, returning true if it does and false otherwise.

	.EXAMPLE
	Test-PowerShellProfileImportsTiPS -Verbose

	Tests whether the PowerShell profile imports the tiPS module, returning true if it does and false otherwise.
	If true, the verbose output will list the profile file paths and the lines that import the tiPS module.
	If false, the verbose output will list the profile file paths that it checked.
#>
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	Param()

	[string[]] $profileFilePathsThatExist = GetPowerShellProfileFilePathsThatExist

	if ($null -eq $profileFilePathsThatExist -or $profileFilePathsThatExist.Count -eq 0)
	{
		Write-Verbose "No PowerShell profile files exist."
		return $false
	}

	[string] $requiredContentRegex = 'Import-Module\s.*tiPS'
	[Microsoft.PowerShell.Commands.MatchInfo] $results =
		Select-String -Path $profileFilePathsThatExist -Pattern $requiredContentRegex
	if ($null -ne $results)
	{
		Write-Verbose "The tiPS module is imported by the following profile lines:"
		$results | ForEach-Object {
			Write-Verbose "  $($_.Path): $($_.Line)"
		}
		return $true
	}

	Write-Verbose "The tiPS module is not imported directly by any of the PowerShell profiles: $profileFilePathsThatExist"
	return $false
}
