using module '.\..\tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Calling Add-TiPSImportToPowerShellProfile' {
	BeforeEach {
		New-Variable -Name ContentToAddToProfile -Value 'Import-Module -Name tiPS # Added by tiPS to get automatic tips and updates.'

		[string] $ProfileFilePath = 'TestDrive:/fakeProfile.ps1'
		Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePathToAddImportTo -MockWith { return $ProfileFilePath }
	}

	Context 'When the PowerShell profile does not exist' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $false }
		}

		It 'Should create the file with the import statement' {
			Add-TiPSImportToPowerShellProfile

			Get-Content -Path $ProfileFilePath | Should -Be $ContentToAddToProfile
		}
	}

	Context 'When the PowerShell profile exists, but does not import tiPS' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $false }
			[string] $existingProfileContent = '# An empty profile.'
			Set-Content -Path $ProfileFilePath -Force -Value $existingProfileContent
		}

		It 'Should add the import statement to the file' {
			Add-TiPSImportToPowerShellProfile

			$expectedContent = $existingProfileContent + [System.Environment]::NewLine +
				$ContentToAddToProfile + [System.Environment]::NewLine
			Get-Content -Path $ProfileFilePath -Raw | Should -Be $expectedContent
		}
	}

	Context 'When the PowerShell profile exists, and already imports tiPS' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $true }
			$fileContents = @"
# Some code before the import statement
$ContentToAddToProfile
# Some code after the import statement
"@
			Set-Content -Path $ProfileFilePath -Force -Value $fileContents -NoNewline
		}

		It 'Should not modify the file' {
			Add-TiPSImportToPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Be $fileContents
		}
	}
}
