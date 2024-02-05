# These tests are runs as part of the deployment process to ensure the newly published module is working as expected.
# These tests run against the installed module, not the source code, so they do not use mocks and are more of a real-world test.
# Since mocks are not used, we must be careful to not rely on state stored on the machine, such as the module Configuration file.
# To run these tests on your local machine, see the comments in the BeforeAll block.

BeforeAll {
	Import-Module -Name tiPS -Force

	# To run these tests on your local machine, comment out the Import-Module command above and uncomment the one below.
	# 	Do this to use the module version from source code, not the installed version.
	# 	This is necessary to test functionality that you've added to the module, but have not yet published and installed.
	# Import-Module "$PSScriptRoot\..\src\tiPS" -Force
}

Describe 'Get-PowerShellTip' {
	Context 'Given no parameters' {
		It 'Should return a tip' {
			$tip = Get-PowerShellTip
			$tip | Should -Not -BeNullOrEmpty
		}
	}

	Context 'Given a valid tip ID' {
		It 'Should return the tip with the specified ID' {
			$tip = Get-PowerShellTip -Id '2023-07-16-powershell-is-open-source'
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}

	Context 'Given an invalid tip ID' {
		It 'Should write an error' {
			Get-PowerShellTip -Id 'TipIdThatDoesNotExist' -ErrorVariable tipError -ErrorAction SilentlyContinue > $null
			$tipError | Should -Not -BeNullOrEmpty
		}
	}

	Context 'Given the All switch' {
		It 'Should return all tips' {
			$allTips = Get-PowerShellTip -All
			$allTips | Should -Not -BeNullOrEmpty
			$allTips.Count | Should -BeGreaterThan 2
		}

		It 'Should not return any expired tips, as they should have been removed during initialization' {
			$allTips = Get-PowerShellTip -All
			$expiredTips = $allTips.Values | Where-Object { $_.ExpiryDate -lt [DateTime]::Today }
			$expiredTips | Should -BeNullOrEmpty
		}
	}
}

Describe 'Write-PowerShellTip' {
	Context 'Given no parameters' {
		It 'Should write a tip to the terminal without error' {
			{ Write-PowerShellTip } | Should -Not -Throw
		}
	}

	Context 'Given a valid tip ID' {
		It 'Should write the tip to the terminal without error' {
			{ Write-PowerShellTip -Id '2023-07-16-powershell-is-open-source' } | Should -Not -Throw
		}
	}

	Context 'Given an invalid tip ID' {
		It 'Should write an error' {
			Write-PowerShellTip -Id 'TipIdThatDoesNotExist' -ErrorVariable tipError -ErrorAction SilentlyContinue > $null
			$tipError | Should -Not -BeNullOrEmpty
		}
	}
}

Describe 'Test-PowerShellProfileImportsTiPS' {
	Context 'Given the module module was just installed' {
		It 'Should not detect that the module is imported by the PowerShell profile' {
			$profileImportsTiPS = Test-PowerShellProfileImportsTiPS
			$profileImportsTiPS | Should -Be $false
		}
	}
}
