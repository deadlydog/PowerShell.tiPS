using module .\..\src\tiPS\tiPS.psm1

[CmdletBinding()]
Param()

[string] $thisScriptsDirectoryPath = $PSScriptRoot
[string] $repoRootDirectoryPath = Split-Path -Path $thisScriptsDirectoryPath -Parent
[string] $srcDirectoryPath = Join-Path -Path $repoRootDirectoryPath -ChildPath 'src'
[string] $moduleRootDirectoryPath = Join-Path -Path $srcDirectoryPath -ChildPath 'tiPS'
[string] $powerShellTipsDirectoryPath = Join-Path -Path $srcDirectoryPath -ChildPath 'PowerShellTips'
[string] $powerShellTipsJsonFilePath = Join-Path -Path $moduleRootDirectoryPath -ChildPath 'PowerShellTips.json'

Write-Verbose "Finding all PowerShell tip files in '$powerShellTipsDirectoryPath'."
[string[]] $tipFilePaths =
	Get-ChildItem -Path $powerShellTipsDirectoryPath -Filter '*.ps1' -Recurse |
	Select-Object -ExpandProperty FullName

[System.Collections.ArrayList] $tips = @()

Write-Verbose "Reading in and validating $($tipFilePaths.Count) PowerShell tip files."
foreach ($tipFilePath in $tipFilePaths)
{
	# Dot-source the tip file, which should have a $tip variable defined with all of the tip info.
	$tip = $null
	. $tipFilePath

	$tip.Validate()
	$tips.Add($tip) > $null
}

Write-Verbose "Writing $($tips.Count) PowerShell Tip objects to JSON file '$powerShellTipsJsonFilePath'."
$tips |
	Sort-Object -Property CreatedDate |
	ConvertTo-Json -Depth 100 |
	Out-File -FilePath $powerShellTipsJsonFilePath -Encoding UTF8 -Force

Write-Output "$($tips.Count) PowerShell tip files were found in the directory '$powerShellTipsDirectoryPath', successfully converted to JSON, and written to the file '$powerShellTipsJsonFilePath'."
