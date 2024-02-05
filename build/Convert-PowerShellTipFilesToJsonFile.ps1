# This file reads in all of the tip files in the PowerShellTips directory, validates them, and writes them to a JSON file.
# This is done as part of the module's build process so that loading the tips at runtime is as fast as possible.
# Rather than shipping all of the tip files with the module, we ship a single JSON file that contains all of the tips.

[CmdletBinding()]
Param()

[string] $thisScriptsDirectoryPath = $PSScriptRoot
[string] $repoRootDirectoryPath = Split-Path -Path $thisScriptsDirectoryPath -Parent -Resolve
[string] $srcDirectoryPath = Join-Path -Path $repoRootDirectoryPath -ChildPath 'src'
[string] $moduleRootDirectoryPath = Join-Path -Path $srcDirectoryPath -ChildPath 'tiPS'
[string] $powerShellTipsDirectoryPath = Join-Path -Path $srcDirectoryPath -ChildPath 'PowerShellTips'
[string] $powerShellTipsJsonFilePath = Join-Path -Path $moduleRootDirectoryPath -ChildPath 'PowerShellTips.json'

Write-Output "Generating updated PowerShellTips.json file from the tip files in '$powerShellTipsDirectoryPath'."

Write-Verbose "Wiping out the contents of the JSON file '$powerShellTipsJsonFilePath' to ensure it can be loaded by the module."
@{} | ConvertTo-Json | Out-File -FilePath $powerShellTipsJsonFilePath -Encoding UTF8 -Force

Write-Verbose "Importing the tiPS module from '$moduleRootDirectoryPath'."
Import-Module -Name $moduleRootDirectoryPath -Force

Write-Verbose "Finding all PowerShell tip files in '$powerShellTipsDirectoryPath'."
[string[]] $tipFilePaths =
	Get-ChildItem -Path $powerShellTipsDirectoryPath -Filter '*.ps1' -Recurse |
	Select-Object -ExpandProperty FullName

[System.Collections.ArrayList] $tips = @()
[int] $numberOfTipFiles = $tipFilePaths.Count
[int] $numberOfExpiredTipFiles = 0

Write-Verbose "Reading in and validating $numberOfTipFiles PowerShell tip files."
foreach ($tipFilePath in $tipFilePaths)
{
	# Dot-source the tip file, which should have a $tip variable defined with all of the tip info.
	$tip = $null
	. $tipFilePath

	$tip.TrimAllProperties()
	$tip.Validate()

	if ($tip.ExpiryDate -lt [DateTime]::Today)
	{
		Write-Verbose "Skipping expired tip: $($tip.Title)"
		$numberOfExpiredTipFiles++
		continue
	}

	$tips.Add($tip) > $null
}

[int] $numberOfTips = $tips.Count
[int] $numberOfNonExpiredTipFiles = $numberOfTipFiles - $numberOfExpiredTipFiles
if ($numberOfTips -ne $numberOfNonExpiredTipFiles)
{
	throw "Found $numberOfNonExpiredTipFiles non-expired tip files ($numberOfTipFiles files, but $numberOfExpiredTipFiles were expired), but read in $numberOfTips tips. The number of non-expired tip files and tips should match."
}

if ($numberOfTips -eq 0)
{
	throw "No tips were read in from the directory '$powerShellTipsDirectoryPath'. At least one tip file is required."
}

# Ideally we could get the read-only property names with the [JsonIgnore] attribute, but PowerShell
# does not have an easy way to inspect property attributes. Instead do a more brittle string match.
[string[]] $readOnlyClassPropertyNames =
	[tiPS.PowerShellTip]::new() |
	Get-Member -MemberType Property |
	Where-Object { $_.Definition -match '{get;}' } |
	Select-Object -ExpandProperty Name
Write-Verbose "The following read-only properties will be excluded from the JSON file: $readOnlyClassPropertyNames"

Write-Verbose "Writing $numberOfTips PowerShell Tip objects to JSON file '$powerShellTipsJsonFilePath'."
$tips |
	Sort-Object -Property CreatedDate, Title | # Also sort by Title so tips created on the same date are always added in the same order.
	Select-Object -ExcludeProperty $readOnlyClassPropertyNames |
	ConvertTo-Json -Depth 100 |
	Out-File -FilePath $powerShellTipsJsonFilePath -Encoding UTF8 -Force

Write-Output "$numberOfTipFiles PowerShell tip files were found in the directory '$powerShellTipsDirectoryPath', successfully converted to JSON, and written to the file '$powerShellTipsJsonFilePath'."
