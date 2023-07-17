using module .\Tips.psm1

BeforeAll {
	[string] $ModuleName = 'Tips' # Required for mocking functions called by the module.
}

Describe 'Get-PowerShellTip' {
	Context 'Given no parameters' {
		It 'Should return a tip' {
			$tip = Get-PowerShellTip
			$tip | Should -Not -BeNullOrEmpty
		}
	}
}

Describe 'Write-PowerShellTip' {
	Context 'Using one of its aliases' {
		It 'Should write a tip using Write-PSTip' {
			Mock -ModuleName $ModuleName Write-Host { } -Verifiable
			Write-PSTip
			Should -InvokeVerifiable # Verify that the mock was called.
		}
		It 'Should write a tip using Write-Tip' {
			Mock -ModuleName $ModuleName Write-Host { } -Verifiable
			Write-Tip
			Should -InvokeVerifiable # Verify that the mock was called.
		}
		It 'Should write a tip using Tips' {
			Mock -ModuleName $ModuleName Write-Host { } -Verifiable
			Tips
			Should -InvokeVerifiable # Verify that the mock was called.
		}
	}

	Context 'Given no parameters' {
		It 'Should write a tip' {
			Mock -ModuleName $ModuleName Write-Host { } -Verifiable
			Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the mock was called.
		}
	}
}
