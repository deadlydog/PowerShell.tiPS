using module './../tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Get-PowerShellTip' {
	BeforeEach {
		Mock -ModuleName $ModuleName -CommandName GetTipIdsAlreadySeenFilePath -MockWith {
			# We have to use GetUnresolvedProviderPathFromPSPath because the File.ReadAllText method cannot read from the TestDrive provider, and we cannot use Resolve-Path because the file does not exist yet.
			return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('TestDrive:/TipsAlreadySeen.txt')
		}
	}

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
			Get-PowerShellTip -Id 'TipIdThatDoesNotExist' -ErrorVariable error -ErrorAction SilentlyContinue > $null
			$error | Should -Not -BeNullOrEmpty
		}
	}

	Context 'Given the All switch' {
		It 'Should return all tips' {
			[string] $powerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot/../PowerShellTips.json"
			[int] $numberOfTipsInJsonFile =
				Get-Content -Path $powerShellTipsJsonFilePath |
				ConvertFrom-Json |
				Measure-Object |
				Select-Object -ExpandProperty Count

			$allTips = Get-PowerShellTip -All

			$allTips | Should -Not -BeNullOrEmpty
			$allTips.Count | Should -Be $numberOfTipsInJsonFile
		}
	}

	Context 'By piping string IDs to it' {
		It 'Should return the tip with the specified ID' {
			$tip = '2023-07-16-powershell-is-open-source' | Get-PowerShellTip
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}

	Context 'By piping an object with an Id property to it' {
		It 'Should return the tip with the specified ID' {
			$tip = [PsCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Get-PowerShellTip
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}
}

InModuleScope -ModuleName tiPS { # Must use InModuleScope to access script-level variables of the module.
	Describe 'Get-PowerShellTip in module scope' {
		BeforeAll {
			New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.

			[string] $powerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot/../PowerShellTips.json"
			[int] $numberOfTipsInJsonFile =
			Get-Content -Path $powerShellTipsJsonFilePath |
				ConvertFrom-Json |
				Measure-Object |
				Select-Object -ExpandProperty Count
			New-Variable -Name TotalNumberOfTips -Value $numberOfTipsInJsonFile -Option Constant -Force
		}

		BeforeEach {
			Mock -ModuleName $ModuleName -CommandName GetTipIdsAlreadySeenFilePath -MockWith {
				# We have to use GetUnresolvedProviderPathFromPSPath because the File.ReadAllText method cannot read from the TestDrive provider, and we cannot use Resolve-Path because the file does not exist yet.
				return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('TestDrive:/TipsAlreadySeen.txt')
			}

			[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
			$ValidTip.CreatedDate = [DateTime]::Parse('2023-01-15')
			$ValidTip.Title = 'Title of the tip'
			$ValidTip.TipText = 'Tip Text'
			$ValidTip.Example = 'Example'
			$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$ValidTip.MinPowerShellVersion = '5.1'
			$ValidTip.Category = 'Community'
		}

		Context 'When all of the tips have been seen' {
			BeforeEach {
				$script:UnseenTips.Clear()
			}

			It 'Should reset the tips script variable to include all tips and return one of them' {
				$tip = Get-PowerShellTip

				$tip | Should -Not -BeNullOrEmpty
				$script:UnseenTips.Count | Should -Be ($TotalNumberOfTips - 1)
			}
		}

		Context 'When only one tip is still left to be seen' {
			BeforeEach {
				$script:UnseenTips.Clear()
				$script:UnseenTips.Add($ValidTip.Id, $ValidTip)
			}

			It 'Should return the last tip and reset the unseen tips variable to include all tips' {
				$tip = Get-PowerShellTip

				$tip.Id | Should -Be $ValidTip.Id
				$script:UnseenTips.Count | Should -Be $TotalNumberOfTips
			}
		}
	}
}
