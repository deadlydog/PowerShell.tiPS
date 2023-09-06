function Edit-PowerShellProfileToImportTiPS
{
	[CmdletBinding(SupportsShouldProcess = $true)]
	Param()

	Process
	{
		[bool] $moduleIsAlreadyInProfile = Test-PowerShellProfileImportsTiPS
		if ($moduleIsAlreadyInProfile)
		{
			Write-Verbose "PowerShell profile already imports the tiPS module."
			return
		}

		[string] $profileFilePath = $PROFILE.CurrentUserAllHosts
		[string] $contentToAddToProfile = 'Import-Module -Name tiPS # Added by tiPS.'

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
