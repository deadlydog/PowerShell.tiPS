using module './../tiPS.psm1'

# Prevent PSScriptAnalyzer from throwing errors for using aliases when we want to test them.
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]
Param()

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking public functions called by the module.
}

Describe 'Write-PowerShellTip' {
	BeforeEach {
		Mock -ModuleName $ModuleName Write-Host { } -Verifiable
	}

	Context 'Using one of its aliases' {
		It 'Should write a tip using Tips' {
			Tips
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}
	}

	Context 'Given no parameters' {
		It 'Should write a tip' {
			Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}
	}

	Context 'Given an ID via piping' {
		It 'Should write the tip with the specified ID' {
			'2023-07-16-powershell-is-open-source' | Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}

		It 'Should write the tip with the specified ID of the object' {
			[PsCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}
	}
}
