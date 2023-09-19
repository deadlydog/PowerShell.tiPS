# These tests are runs as part of the deployment process to ensure the newly published module is working as expected.
# These tests run against the newly installed module, not the source code, so they are more of a real-world test.

BeforeAll {
	Import-Module -Name tiPS -Force
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
