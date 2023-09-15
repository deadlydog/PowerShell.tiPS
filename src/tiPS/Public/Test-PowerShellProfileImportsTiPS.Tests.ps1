using module './../tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Calling Test-PowerShellProfileImportsTiPS' {
	Context 'When the PowerShell profile files do not exist' {
		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePathsThatExist -MockWith { return $null }
		}

		It 'Should return false' {
			$result = Test-PowerShellProfileImportsTiPS
			$result | Should -Be $false
		}
	}

	Context 'When the PowerShell profiles exist, but do not import tiPS' {
		BeforeEach {
			$fakeProfileFilePath = 'TestDrive:/fakeProfile.ps1'
			Set-Content -Path $fakeProfileFilePath -Force -Value @'
# This is a fake PowerShell profile.
'@
			Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePathsThatExist -MockWith { return @($fakeProfileFilePath) }
		}

		It 'Should return false' {
			$result = Test-PowerShellProfileImportsTiPS
			$result | Should -Be $false
		}
	}

	Context 'When the PowerShell profiles exist and do import tiPS' {
		BeforeEach {
			$fakeProfileFilePath = 'TestDrive:/fakeProfile.ps1'
			Set-Content -Path $fakeProfileFilePath -Force -Value @'
# This fake PowerShell profile imports tiPS.
Import-Module -Name tiPS
'@
			Mock -ModuleName $ModuleName -CommandName GetPowerShellProfileFilePathsThatExist -MockWith { return @($fakeProfileFilePath) }
		}

		It 'Should return true' {
			$result = Test-PowerShellProfileImportsTiPS
			$result | Should -Be $true
		}
	}
}
