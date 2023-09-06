BeforeAll {
	. "$PSScriptRoot\Test-ProfileImportsTiPS.ps1"
}

Describe 'Calling Test-ProfileImportsTiPS' {
	Context 'When the PowerShell profiles do not exist' {
		BeforeEach {
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @('TestDrive:\DoesNotExist.ps1') }
		}

		It 'Should return false' {
			$result = Test-ProfileImportsTiPS
			$result | Should -Be $false
		}
	}

	Context 'When the PowerShell profiles do not import tiPS' {
		BeforeEach {
			$fakeProfileFilePath = 'TestDrive:\fakeProfile.ps1'
			Set-Content -Path $fakeProfileFilePath -Force -Value @'
# This is a fake PowerShell profile.
'@
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @($fakeProfileFilePath) }
		}

		It 'Should return false' {
			$result = Test-ProfileImportsTiPS
			$result | Should -Be $false
		}
	}

	Context 'When the PowerShell profiles do import tiPS' {
		BeforeEach {
			$fakeProfileFilePath = 'TestDrive:\fakeProfile.ps1'
			Set-Content -Path $fakeProfileFilePath -Force -Value @'
# This fake PowerShell profile imports tiPS.
Import-Module -Name tiPS
'@
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @($fakeProfileFilePath) }
		}

		It 'Should return true' {
			$result = Test-ProfileImportsTiPS
			$result | Should -Be $true
		}
	}
}
