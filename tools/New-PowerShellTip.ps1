# Run this script to create a new PowerShell Tip file and open it.
# You will be prompted for the tip's title, and then the file will open in your default editor.

# Prompt the user for a title for the new PowerShell Tip.
[string] $tipTitle = [string]::Empty
[int] $maxTitleLength = 75
do
{
	[string] $tipTitle = Read-Host -Prompt 'Enter the title for your new PowerShell tip (e.g. "PowerShell is open source")'

	[bool] $titleWasNotProvided = [string]::IsNullOrWhiteSpace($tipTitle)
	if ($titleWasNotProvided)
	{
		Write-Warning 'A title was not provided, so exiting script.'
		return
	}

	[int] $titleLength = $tipTitle.Length
	if ($titleLength -gt $maxTitleLength)
	{
		Write-Output "The title must be $maxTitleLength characters or less. You entered $titleLength characters. Please enter a shorter title."
	}
} while ($titleLength -gt $maxTitleLength)

. "$PSScriptRoot/Helpers/BuildAndImportTiPSModule.ps1"

# The Tip filename is based on the ID, which is based on the date and title, so load a dummy PowerShellTip to get the filename to use.
$dummyTip = [tiPS.PowerShellTip]::new()
$dummyTip.CreatedDate = [DateTime]::Today
$dummyTip.Title = $tipTitle.Trim()

[string] $createdDate = $dummyTip.CreatedDate.ToString('yyyy-MM-dd')
[string] $powerShellTipsFilesDirectoryPath = Resolve-Path -Path "$PSScriptRoot/../src/PowerShellTips"
[string] $newTipFileName = $dummyTip.Id + '.ps1'
[string] $newTipFilePath = Join-Path -Path $powerShellTipsFilesDirectoryPath -ChildPath $newTipFileName
[string] $tipTemplateFileContents = @"
`$tip = [tiPS.PowerShellTip]::new()
`$tip.CreatedDate = [DateTime]::Parse('$createdDate')
`$tip.Title = '$($tipTitle.Replace("'", "''"))'
`$tip.TipText = @'
A short description of the tip.

This can be multiple lines.

If the tip is for a new feature, mention the PowerShell version the feature was introduced in.
'@
`$tip.Example = @'
Example code to demonstrate the tip. This can also be multiple lines if needed. Use an empty string if no example is provided.
'@
`$tip.Urls = @(
	'https://OneTwoOrThreeUrls'
	'https://ToLearnMoreAboutTheTip'
	'https://UseAnEmptyArrayIfNoUrlsAreProvided'
)
`$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
`$tip.Author = 'Your name and/or username' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#`$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Category meanings:
# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VS Code, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, keywords, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
"@

Write-Output "Creating new PowerShell Tip file and opening it: $newTipFilePath"
Set-Content -Path $newTipFilePath -Value $tipTemplateFileContents -Encoding utf8 -Force
try
{
	Invoke-Item -Path $newTipFilePath -ErrorVariable openTipFileError
}
catch
{
	# GitHub Codespaces will throw an error when trying to open the file, but will open it fine using VS Code (code.exe).
	# Use the try-catch to suppress the exception thrown in Codespaces when it fails to open the file.
	if ($openTipFileError)
	{
		& code "$newTipFilePath"
	}
}
