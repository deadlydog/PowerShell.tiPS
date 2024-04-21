using module '.\..\tiPS.psm1'

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
		}

		It 'Should remove the import statement that was automatically added to the profile file' {
			Set-Content -Path $ProfileFilePath -Force -Value $ContentToAddToProfile

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$ContentToAddToProfile*"
		}

		It 'Should remove a common import statement that was manually added to the profile file (1)' {
			[string] $manuallyAddedImportStatement = 'Import-Module -Name tiPS -Force'
			Set-Content -Path $ProfileFilePath -Force -Value $manuallyAddedImportStatement

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}

		It 'Should remove a common import statement that was manually added to the profile file (2)' {
			[string] $manuallyAddedImportStatement = 'Import-Module -Name tiPS'
			Set-Content -Path $ProfileFilePath -Force -Value $manuallyAddedImportStatement

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}

		It 'Should remove a common import statement that was manually added to the profile file (3)' {
			[string] $manuallyAddedImportStatement = 'Import-Module tiPS -Force'
			Set-Content -Path $ProfileFilePath -Force -Value $manuallyAddedImportStatement

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}

		It 'Should remove a common import statement that was manually added to the profile file (4)' {
			[string] $manuallyAddedImportStatement = 'Import-Module tiPS'
			Set-Content -Path $ProfileFilePath -Force -Value $manuallyAddedImportStatement

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}

		It 'Should remove a common import statement that was manually added to the profile file with whitespace' {
			[string] $manuallyAddedImportStatement = 'Import-Module -Name tiPS -Force'
			Set-Content -Path $ProfileFilePath -Force -Value "	$manuallyAddedImportStatement  "

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}

		It 'Should remove a common import statement that was manually added to a multiline profile file with whitespace' {
			[string] $manuallyAddedImportStatement = 'Import-Module -Name tiPS'
			[string] $profileContents = @"
Import-Module oh-my-posh
	  $manuallyAddedImportStatement
Import-Module posh-git
"@
			Set-Content -Path $ProfileFilePath -Force -Value $profileContents

			Remove-TiPSImportFromPowerShellProfile

			Get-Content -Path $ProfileFilePath -Raw | Should -Not -BeLike "*$manuallyAddedImportStatement*"
		}
	}
}
