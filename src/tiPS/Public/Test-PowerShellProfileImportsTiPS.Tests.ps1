BeforeAll {
	. "$PSScriptRoot/Test-PowerShellProfileImportsTiPS.ps1"
}

Describe 'Calling Test-PowerShellProfileImportsTiPS' {
	Context 'When the PowerShell profile files do not exist' {
		BeforeEach {
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @('TestDrive:/DoesNotExist.ps1') }
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
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @($fakeProfileFilePath) }
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
			Mock -CommandName GetPowerShellProfileFilePaths -MockWith { return @($fakeProfileFilePath) }
		}

		It 'Should return true' {
			$result = Test-PowerShellProfileImportsTiPS
			$result | Should -Be $true
		}
	}
}
