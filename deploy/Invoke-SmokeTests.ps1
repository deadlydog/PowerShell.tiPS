# These tests are runs as part of the deployment process to ensure the newly published module is working as expected.
# These tests run against the installed module, not the source code, so they are more of a real-world test.

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
			$tip = Get-PowerShellTip -TipId '2023-07-16-powershell-is-open-source'
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}

	Context 'Given an invalid tip ID' {
		It 'Should write an error' {
			Get-PowerShellTip -TipId 'TipIdThatDoesNotExist' -ErrorVariable error -ErrorAction SilentlyContinue > $null
			$error | Should -Not -BeNullOrEmpty
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
