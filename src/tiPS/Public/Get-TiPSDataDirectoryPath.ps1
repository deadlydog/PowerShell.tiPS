function Get-TiPSDataDirectoryPath
{
<#
	.SYNOPSIS
	Get the tiPS data directory path.

	.DESCRIPTION
	Get the tiPS data directory path where the tiPS module stores all of its data for the current user.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	A [string] of the directory path.

	.EXAMPLE
	Get-TiPSDataDirectoryPath

	Get the tiPS data directory path.
#>
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $usersLocalAppDataPath =
		[System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)
	[string] $appDataDirectoryPath =
		Join-Path -Path $usersLocalAppDataPath -ChildPath (
		Join-Path -Path 'PowerShell' -ChildPath 'tiPS')

	[bool] $directoryDoesNotExist = -not (Test-Path -Path $appDataDirectoryPath -PathType Container)
	if ($directoryDoesNotExist)
	{
		Write-Verbose "Creating tiPS data directory '$appDataDirectoryPath'."
		New-Item -Path $appDataDirectoryPath -ItemType Directory -Force > $null
	}

	return $appDataDirectoryPath
}
