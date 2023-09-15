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

function GetPowerShellProfileFilePathsThatExist
{
	[string[]] $powerShellProfileFilePaths = GetPowerShellProfileFilePaths
	[string[]] $profileFilePathsThatExist =
		$powerShellProfileFilePaths |
		Where-Object { Test-Path -Path $_ -PathType Leaf }

	return ,$profileFilePathsThatExist
}

function GetPowerShellProfileFilePathToAddImportTo
{
	[string] $profileFilePath = [string]::Empty

	# The $PROFILE variable may not exist depending on the host or the context in which PowerShell was started.
	if (Test-Path -Path variable:PROFILE)
	{
		$profileFilePath = $PROFILE.CurrentUserAllHosts
	}

	return $profileFilePath
}

function GetImportStatementToAddToPowerShellProfile
{
	return 'Import-Module -Name tiPS # Added by tiPS to get automatic tips and updates.'
}
