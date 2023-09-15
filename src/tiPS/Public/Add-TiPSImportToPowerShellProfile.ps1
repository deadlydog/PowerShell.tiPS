function Add-TiPSImportToPowerShellProfile
{
<#
	.SYNOPSIS
	Adds the tiPS Import-Module statement to the user's PowerShell profile file.

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
	Add-TiPSImportToPowerShellProfile

	This example edits the PowerShell profile to add a tiPS Import-Module statement.
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

		[string] $profileFilePath = GetPowerShellProfileFilePathToAddImportTo
		[string] $contentToAddToProfile = GetImportStatementToAddToPowerShellProfile

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
