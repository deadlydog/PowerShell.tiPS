using module '.\..\tiPS.psm1'

# Prevent PSScriptAnalyzer from throwing errors for using aliases when we want to test them.
[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingCmdletAliases', '')]
Param()

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Write-PowerShellTip' {
	BeforeEach {
		Mock -ModuleName $ModuleName Write-Host { } -Verifiable
	}

	Context 'Given no parameters' {
		It 'Should write a tip without error' {
			$Error.Clear()
			{ Write-PowerShellTip } | Should -Not -Throw
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
			$Error[0] | Should -BeNullOrEmpty
		}
	}

	Context 'Given a valid tip ID' {
		It 'Should write the tip to the terminal without error' {
			$Error.Clear()
			{ Write-PowerShellTip -Id '2023-07-16-powershell-is-open-source' } | Should -Not -Throw
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
			$Error[0] | Should -BeNullOrEmpty
		}
	}

	Context 'Given an invalid tip ID' {
		It 'Should write an error' {
			Write-PowerShellTip -Id 'TipIdThatDoesNotExist' -ErrorVariable tipError -ErrorAction SilentlyContinue > $null
			$tipError | Should -Not -BeNullOrEmpty
		}
	}

	Context 'Using one of its aliases' {
		It 'Should write a tip using Tips' {
			{ Tips } | Should -Not -Throw
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}
	}

	Context 'Given an ID via piping' {
		It 'Should write the tip with the specified ID' {
			'2023-07-16-powershell-is-open-source' | Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}

		It 'Should write the tip with the specified ID of the object' {
			[PSCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Write-PowerShellTip
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
		}
	}

	Context 'Given the Previous switch' {
		BeforeEach {
			# Use a temp configuration data directory instead of reading/overwriting the current user's configuration.
			Mock -ModuleName $ModuleName -CommandName Get-TiPSDataDirectoryPath -MockWith {
				[string] $directoryPath = "$TestDrive/tiPS" # Use $TestDrive variable so .NET methods can resolve the path.
				if (-not (Test-Path -Path $directoryPath -PathType Container))
				{
					New-Item -Path $directoryPath -ItemType Directory -Force > $null
				}
				return $directoryPath
			}
		}

		It 'Should write the last shown tip without error' {
			InModuleScope -ModuleName $ModuleName {
				# Show a tip to populate the last shown tip ID
				AppendTipIdToTipIdsAlreadyShown -TipId '2023-07-16-powershell-is-open-source'
			}

			$Error.Clear()
			{ Write-PowerShellTip -Previous } | Should -Not -Throw
			Should -InvokeVerifiable # Verify that the Write-Host mock was called.
			$Error[0] | Should -BeNullOrEmpty
		}

		It 'Should write an error when no tips have been shown yet' {
			InModuleScope -ModuleName $ModuleName {
				# Clear all shown tips
				ClearTipIdsAlreadyShown
			}

			Write-PowerShellTip -Previous -ErrorVariable tipError -ErrorAction SilentlyContinue > $null
			$tipError | Should -Not -BeNullOrEmpty
		}
	}
}
