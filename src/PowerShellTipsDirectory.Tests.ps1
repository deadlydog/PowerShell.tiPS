BeforeAll {
	. "$PSScriptRoot\tiPS\Classes\PowerShellTip.ps1"
}

Describe 'The files in the PowerShellTips directory' {
	It 'Should have their file name in the correct format (yyyy-mm-dd-kebab-case-id.ps1)' {
		[string] $fileNameRegex =
		'^\d{4}-\d{2}-\d{2}' + # Starts with a date in the format yyyy-mm-dd.
		'-' + # Followed by a hyphen.
		'[a-z0-9-]+' + # Followed by any number of lower-case kebab-case words.
		'\.ps1$' # Ends with the file extension .ps1.

		$tipFiles = Get-ChildItem -Path "$PSScriptRoot\PowerShellTips" -File
		$tipFiles | ForEach-Object {
			$_.Name | Should -cMatch $fileNameRegex
		}
	}

	It 'Should have their file name match their ID' {
		$tipFiles = Get-ChildItem -Path "$PSScriptRoot\PowerShellTips" -File
		$tipFiles | ForEach-Object {
			[tiPS.PowerShellTip] $tip = $null
			. $_.FullName # Loads the tip into the $tip variable.
			$tip.Id | Should -Be $_.BaseName
		}
	}
}
