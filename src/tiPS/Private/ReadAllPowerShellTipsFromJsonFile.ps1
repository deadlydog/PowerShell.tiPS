function ReadAllPowerShellTipsFromJsonFile
{
	[CmdletBinding()]
	Param()

	[string] $moduleRootDirectoryPath = Split-Path -Path $PSScriptRoot -Parent
	[string] $powerShellTipsJsonFilePath = Join-Path -Path $moduleRootDirectoryPath -ChildPath 'PowerShellTips.json'
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
