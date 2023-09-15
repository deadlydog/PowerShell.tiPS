using module './../tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Calling Remove-TiPSImportFromPowerShellProfile' {
	BeforeEach {
		New-Variable -Name ContentToAddToProfile -Value 'Import-Module -Name tiPS # Added by tiPS to get automatic tips and updates.'

		[string] $ProfileFilePath = 'TestDrive:/fakeProfile.ps1'
		Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePathsThatExist -MockWith { return @($ProfileFilePath) }
	}

	Context 'When no PowerShell profiles import the tiPS module' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $false }
		}

		It 'Should should not do anything' {
			$verboseOutput = Remove-TiPSImportFromPowerShellProfile -Verbose 4>&1

			$verboseOutput | Should -BeLike '*no changes are necessary*'
		}
	}

	Context 'When a PowerShell profile that imports tiPS exists' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName Test-PowerShellProfileImportsTiPS -MockWith { return $true }
			Set-Content -Path $ProfileFilePath -Force -Value $ContentToAddToProfile
		}

		It 'Should remove the import statement from the profile file' {
			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath | Should -Not -Contain $ContentToAddToProfile
		}
	}
}
