function ReadAllPowerShellTipsFromJsonFile
{
	[CmdletBinding()]
	[OutputType([System.Collections.Specialized.OrderedDictionary])]
	Param()

	[string] $powerShellTipsJsonFilePath = Join-Path -Path $script:PSModuleRoot -ChildPath 'PowerShellTips.json'

	Write-Verbose "Reading PowerShell tips from '$powerShellTipsJsonFilePath'."
	[tiPS.PowerShellTip[]] $tipObjects =
		[System.IO.File]::ReadAllText($powerShellTipsJsonFilePath) | # Use .NET method instead of Get-Content for performance.
		ConvertFrom-Json
		# We assume the tips are sorted by CreatedDate when added to the json file, so we don't need to sort them again here.
		# Otherwise we would just append '| Sort-Object -Property CreatedDate' here.

	[System.Collections.Specialized.OrderedDictionary] $tipHashtable = [System.Collections.Specialized.OrderedDictionary]::new()
	foreach ($tip in $tipObjects)
	{
		$tipHashtable[$tip.Id] = $tip
	}

	return $tipHashtable
}
