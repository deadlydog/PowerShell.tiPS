function ReadAllPowerShellTipsFromJsonFile
{
	[CmdletBinding()]
	[OutputType([System.Collections.Specialized.OrderedDictionary])]
	Param()

	[string] $moduleRootDirectoryPath = Split-Path -Path $PSScriptRoot -Parent
	[string] $powerShellTipsJsonFilePath = Join-Path -Path $moduleRootDirectoryPath -ChildPath 'PowerShellTips.json'

	Write-Verbose "Reading PowerShell tips from '$powerShellTipsJsonFilePath'."
	[tiPS.PowerShellTip[]] $tipObjects =
		Get-Content -Path $powerShellTipsJsonFilePath -Raw |
		ConvertFrom-Json

	[hashtable] $tipHashtable = [ordered]@{}
	foreach ($tip in $tipObjects)
	{
		$tipHashtable[$tip.Id] = $tip
	}

	return $tipHashtable
}
