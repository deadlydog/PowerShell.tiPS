using module .\..\tiPS.psm1

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking public functions called by the module.
}

Describe 'Calling Edit-PowerShellProfileToImportTiPS' {
	BeforeEach {
		New-Variable -Name ContentToAddToProfile -Value 'Import-Module -Name tiPS # Added by tiPS.'

		[string] $ProfileFilePath = 'TestDrive:\fakeProfile.ps1'
		Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePath -MockWith { return $ProfileFilePath }
	}

	Context 'When the PowerShell profile does not exist' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $false }
		}

		It 'Should create the file with the import statement' {
			Edit-PowerShellProfileToImportTiPS

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
			Edit-PowerShellProfileToImportTiPS

			$expectedContent = $existingProfileContent + [System.Environment]::NewLine +
				$ContentToAddToProfile + [System.Environment]::NewLine
			Get-Content -Path $ProfileFilePath -Raw | Should -Be $expectedContent
		}
	}

	Context 'When the PowerShell profile exists, and already imports tiPS' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $true }
			Set-Content -Path $ProfileFilePath -Force -Value $ContentToAddToProfile
		}

		It 'Should not modify the file' {
			Edit-PowerShellProfileToImportTiPS

			Get-Content -Path $ProfileFilePath | Should -Be $ContentToAddToProfile
		}
	}
}