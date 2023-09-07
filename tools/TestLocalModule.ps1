# Run this script to easily load the module from code and see the end-user experience.

# Prevent PSScriptAnalyzer from throwing errors for using aliases when we want to test them.
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]
Param()

Import-Module "$PSScriptRoot\..\src\tiPS" -Force

Get-PowerShellTip

Write-PowerShellTip

Tips

Test-PowerShellProfileImportsTiPS
