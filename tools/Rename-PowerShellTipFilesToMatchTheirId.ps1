# This script ensures that all PowerShell Tip files in the src/PowerShellTips directory have their ID as their filename.

# Add the class types directly instead of importing the module, since all we need are the classes.
Add-Type -Path "$PSScriptRoot/../src/tiPS/Classes/tiPSClasses.dll"

[string] $powerShellTipFilesDirectoryPath = Resolve-Path -Path "$PSScriptRoot/../src/PowerShellTips"

Write-Output "Ensuring all PowerShell Tip files in '$powerShellTipFilesDirectoryPath' have their ID as their filename."
[int] $numberOfFilesRenamed = 0
$tipFiles = Get-ChildItem -Path $powerShellTipFilesDirectoryPath -File
$tipFiles | ForEach-Object {
	$file = $_

	[tiPS.PowerShellTip] $tip = $null
	. $file.FullName # Loads the tip into the $tip variable.

	if ($tip.Id -ne $file.BaseName)
	{
		[string] $newFileName = $tip.Id + '.ps1'
		Write-Output "Renaming '$($file.Name)' to '$newFileName'."
		Rename-Item -Path $file.FullName -NewName $newFileName -Force
		$numberOfFilesRenamed++
	}
}

Write-Output "$numberOfFilesRenamed PowerShell tip files were renamed."
