using module .\..\tiPS.psm1

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Write-PowerShellTip' {
	Context 'Using one of its aliases' {
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
