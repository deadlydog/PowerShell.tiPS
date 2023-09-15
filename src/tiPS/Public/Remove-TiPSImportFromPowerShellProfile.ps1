function Remove-TiPSImportFromPowerShellProfile
{
<#
	.SYNOPSIS
	Removes the tiPS Import-Module statement from the user's PowerShell profile file.

	.DESCRIPTION
	This function edits the user's PowerShell profile file to remove the Import-Module statement that is
	used to import the tiPS module. If the profile does not import the tiPS module, then no changes are made.
	Only the default PowerShell profile paths are searched to see if the tiPS module is imported; if
	it is imported from a dot-sourced script, the function will not detect the import statement and it will
	not be removed.

	This function will only remove the tiPS import statement added by the Add-TiPSImportToPowerShellProfile
	function. If you manually added the import statement to your profile, this function may not remove it.

	.INPUTS
	None. You cannot pipe objects to the function.

	.OUTPUTS
	None. The function does not return any objects.

	.EXAMPLE
	Remove-TiPSImportFromPowerShellProfile

	This example edits the PowerShell profile to remove the tiPS Import-Module statement.
#>
	[CmdletBinding(SupportsShouldProcess = $true)]
	[OutputType([void])]
	Param()

	Process
	{
		[bool] $moduleImportStatementIsInProfile = Test-PowerShellProfileImportsTiPS
		if (-not $moduleImportStatementIsInProfile)
		{
			Write-Verbose "The PowerShell profiles do not import the tiPS module, so no changes are necessary."
			return
		}

		[string[]] $profileFilePathsThatExist = GetPowerShellProfileFilePathsThatExist
		[string] $contentToRemoveFromProfile = GetImportStatementToAddToPowerShellProfile

		[bool] $atLeastOneProfileFileModified = $false
		foreach ($profileFilePath in $profileFilePathsThatExist)
		{
			[string] $fileContents = Get-Content -Path $profileFilePath -Raw
			if ($fileContents.Contains($contentToRemoveFromProfile))
			{
				if ($PSCmdlet.ShouldProcess("PowerShell profile '$profileFilePath'", 'Update'))
				{
					Write-Verbose "Removing '$contentToRemoveFromProfile' from PowerShell profile '$profileFilePath'."
					[string] $updatedFileContents = $fileContents -replace $contentToRemoveFromProfile, ''
					Set-Content -Path $profileFilePath -Value $updatedFileContents -Force
				}

				$atLeastOneProfileFileModified = $true
			}
		}

		if (-not $atLeastOneProfileFileModified)
		{
			Write-Warning "One of the PowerShell profiles does import the tiPS module, but not with the expected import statement '$contentToRemoveFromProfile'. Run 'Test-PowerShellProfileImportsTiPS -Verbose' to see which profile files import the tiPS module, and then manually remove the statement from the file."
		}
	}
}
