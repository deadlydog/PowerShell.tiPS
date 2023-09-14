function Edit-PowerShellProfileToImportTiPS
{
<#
	.SYNOPSIS
	Edits the user's PowerShell profile file to import the tiPS module.

	.DESCRIPTION
	This function edits the user's PowerShell profile file to import the tiPS module, which can provide
	automatic tips and updates. If the profile already imports the tiPS module, then no changes are made.
	Only the default PowerShell profile paths are searched to see if the tiPS module is already imported; if
	it is imported from a dot-sourced script, the function will not detect that and will add an import statement
	directly to the profile file.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	None. The function does not return any objects.

	.EXAMPLE
	Edit-PowerShellProfileToImportTiPS

	This example edits the PowerShell profile to import the tiPS module.
#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([void])]
	Param()

	Process
	{
		[bool] $moduleImportStatementIsAlreadyInProfile = Test-PowerShellProfileImportsTiPS
		if ($moduleImportStatementIsAlreadyInProfile)
		{
			Write-Verbose "PowerShell profile already imports the tiPS module, so no changes are necessary."
			return
		}

		[string] $profileFilePath = GetPowerShellProfileFilePath
		[string] $contentToAddToProfile = 'Import-Module -Name tiPS # Added by tiPS to get automatic tips and updates.'

		if ([string]::IsNullOrWhiteSpace($profileFilePath))
		{
			Write-Error "Could not determine the PowerShell profile file path."
			return
		}

		if (-not (Test-Path -Path $profileFilePath -PathType Leaf))
		{
			if ($PSCmdlet.ShouldProcess("PowerShell profile '$profileFilePath'", 'Create'))
			{
				Write-Verbose "Creating PowerShell profile '$profileFilePath'."
				New-Item -Path $profileFilePath -ItemType File -Force > $null
			}
		}

		if ($PSCmdlet.ShouldProcess("PowerShell profile '$profileFilePath'", 'Update'))
		{
			Write-Verbose "Adding '$contentToAddToProfile' to PowerShell profile '$profileFilePath'."
			Add-Content -Path $profileFilePath -Value $contentToAddToProfile -Force
		}
	}
}

# Use a function to get the file path so we can mock this function for testing.
function GetPowerShellProfileFilePath
{
	[string] $profileFilePath = [string]::Empty

	# The $PROFILE variable may not exist depending on the host or the context in which PowerShell was started.
	if (Test-Path -Path variable:PROFILE)
	{
		$profileFilePath = $PROFILE.CurrentUserAllHosts
	}

	return $profileFilePath
}
