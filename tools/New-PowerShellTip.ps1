# Run this script to create a new PowerShell Tip file and open it.
# You will be prompted for the tip's title, and then the file will open in your default editor.

[string] $tipTitle = Read-Host -Prompt 'Enter the title for your new PowerShell tip (e.g. "PowerShell is open source")'

# The Tip filename will be based on the date and title, so load a dummy PowerShellTip with the title to get the Id to use.
. "$PSScriptRoot\..\src\tiPS\Classes\PowerShellTip.ps1"
$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Today
$tip.Title = $tipTitle

[string] $today = $tip.CreatedDate.ToString('yyyy-MM-dd')
[string] $newTipFileName = $tip.Id + '.ps1'
[string] $newTipFilePath = Join-Path -Path "$PSScriptRoot\..\src\PowerShellTips" -ChildPath $newTipFileName
[string] $tipTemplateFileContents = @"
`$tip = [tiPS.PowerShellTip]::new()
`$tip.CreatedDate = [DateTime]::Parse('$today')
`$tip.Title = '$tipTitle'
`$tip.TipText = @'
A short description of the tip.

This can be multiple lines.
'@
`$tip.Example = 'Example code to demonstrate the tip. This can also be multiple lines if needed.'
`$tip.Urls = @('https://OneTwoOrThreeUrls', 'https://ToLearnMoreAboutTheTip')
`$tip.MinPowerShellVersion = '0.0'
`$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, Syntax, Terminal, or Other.
"@

# Create the new PowerShell Tip file and open it.
Set-Content -Path $newTipFilePath -Value $tipTemplateFileContents -Force
Invoke-Item -Path $newTipFilePath
