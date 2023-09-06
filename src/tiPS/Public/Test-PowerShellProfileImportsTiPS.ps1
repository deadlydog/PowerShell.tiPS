function Test-PowerShellProfileImportsTiPS
{
	[CmdletBinding()]
	[OutputType([bool])]
	Param()

	[string[]] $powerShellProfileFilePaths = GetPowerShellProfileFilePaths
	[string[]] $profileFilePathsThatExist =
		$powerShellProfileFilePaths |
		Where-Object { Test-Path -Path $_ -PathType Leaf }

	if ($profileFilePathsThatExist.Count -eq 0)
	{
		Write-Verbose "No PowerShell profile files exist."
		return $false
	}

	[string] $requiredContentRegex = 'Import-Module\s.*tiPS'
	$results = Select-String -Path $profileFilePathsThatExist -Pattern $requiredContentRegex
	if ($results.Matches.Count -gt 0)
	{
		Write-Verbose "The tiPS module is imported by the following profile lines:"
		$results.Matches | ForEach-Object {
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
	return @(
		$PROFILE.CurrentUserAllHosts
		$PROFILE.CurrentUserCurrentHost
		$PROFILE.AllUsersAllHosts
		$PROFILE.AllUsersCurrentHost
	)
}
