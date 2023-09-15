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

	.EXAMPLE
	Test-PowerShellProfileImportsTiPS

	Tests whether the PowerShell profile imports the tiPS module, returning true if it does and false otherwise.

	.EXAMPLE
	Test-PowerShellProfileImportsTiPS -Verbose

	Tests whether the PowerShell profile imports the tiPS module, returning true if it does and false otherwise.
	If true, the verbose output will list the profile file paths and the lines that import the tiPS module.
	If false, the verbose output will list the profile file paths that it checked.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	System.Boolean representing if the tiPS module is imported by the PowerShell profile or not.

	.NOTES
	This function is intended to be used by the Edit-PowerShellProfileToImportTiPS function.

	.LINK
	Edit-PowerShellProfileToImportTiPS
#>
	[CmdletBinding()]
	[OutputType([System.Boolean])]
	Param()

	[string[]] $powerShellProfileFilePaths = GetPowerShellProfileFilePaths
	[string[]] $profileFilePathsThatExist =
		$powerShellProfileFilePaths |
		Where-Object { Test-Path -Path $_ -PathType Leaf }

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

	Write-Verbose "The tiPS module is not imported by any of the PowerShell profiles: $profileFilePathsThatExist"
	return $false
}

# Use a function to get the file paths so we can mock this function for testing.
function GetPowerShellProfileFilePaths
{
	[string[]] $profileFilePaths = @()

	# The $PROFILE variable may not exist depending on the host or the context in which PowerShell was started.
	if (Test-Path -Path variable:PROFILE)
	{
		$profileFilePaths = @(
			$PROFILE.CurrentUserAllHosts
			$PROFILE.CurrentUserCurrentHost
			$PROFILE.AllUsersAllHosts
			$PROFILE.AllUsersCurrentHost
		)
	}

	return ,$profileFilePaths
}
