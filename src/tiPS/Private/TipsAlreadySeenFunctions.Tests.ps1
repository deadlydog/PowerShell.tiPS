using module './../tiPS.psm1'

InModuleScope -ModuleName tiPS { # Must use InModuleScope to call private functions of the module.
	Describe 'Calling RemoveTipsAlreadySeen' {
		BeforeAll {
			function CloneTip([tiPS.PowerShellTip] $tip)
			{
				[tiPS.PowerShellTip] $newTip = [tiPS.PowerShellTip]::new()
				$newTip.CreatedDate = $tip.CreatedDate
				$newTip.Title = $tip.Title
				$newTip.TipText = $tip.TipText
				$newTip.Example = $tip.Example
				$newTip.Urls = $tip.Urls
				$newTip.MinPowerShellVersion = $tip.MinPowerShellVersion
				$newTip.Category = $tip.Category
				return $newTip
			}
		}
		
		BeforeEach {
			Mock -CommandName GetTipIdsAlreadySeenFilePath -MockWith {
				# We have to use GetUnresolvedProviderPathFromPSPath because the File.ReadAllText method cannot read from the TestDrive provider, and we cannot use Resolve-Path because the file does not exist yet.
				return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('TestDrive:/TipsAlreadySeen.txt')
			}

			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-01-15')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'

			# Clone our valid tip to make multiple instances.
			[tiPS.PowerShellTip] $testTip1 = CloneTip -tip $validTip
			[tiPS.PowerShellTip] $testTip2 = CloneTip -tip $validTip
			[tiPS.PowerShellTip] $testTip3 = CloneTip -tip $validTip
			$testTip1.Title = 'Tip 1'
			$testTip2.Title = 'Tip 2'
			$testTip3.Title = 'Tip 3'

			[hashtable] $testTips = @{
				($testTip1.Id) = $testTip1
				($testTip2.Id) = $testTip2
				($testTip3.Id) = $testTip3
			}
			$testTips.Count | Should -Be 3 # This is here to eliminate the PSScriptAnalyzer warning about unused variables.

			ClearTipIdsAlreadySeen
		}

		It 'Should remove a tip that has already been seen' {
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip1.Id

			RemoveTipsAlreadySeen -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 2
		}

		It 'Should remove multiple tips that have already been seen' {
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip1.Id
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip2.Id

			RemoveTipsAlreadySeen -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Not -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 1
		}

		It 'Should remove all of the tips if they have all been seen' {
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip1.Id
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip2.Id
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip3.Id

			RemoveTipsAlreadySeen -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Not -Contain $testTip2.Id
			$testTips.Keys | Should -Not -Contain $testTip3.Id
			$testTips.Count | Should -Be 0
		}

		It 'Should not remove any tips if none have already been seen' {
			RemoveTipsAlreadySeen -Tips $testTips

			$testTips.Keys | Should -Contain $testTip1.Id
			$testTips.Keys | Should -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 3
		}
	}

	Describe 'Calling ClearTipIdsAlreadySeen' {
		BeforeEach {
			Mock -CommandName GetTipIdsAlreadySeenFilePath -MockWith {
				# We have to use GetUnresolvedProviderPathFromPSPath because the File.ReadAllText method cannot read from the TestDrive provider, and we cannot use Resolve-Path because the file does not exist yet.
				return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('TestDrive:/TipsAlreadySeen.txt')
			}
		}

		Context 'When the file does not exist' {
			It 'Should not throw an exception' {
				[string] $filePath = GetTipIdsAlreadySeenFilePath
				if (Test-Path -Path $filePath -PathType Leaf)
				{
					Remove-Item -Path $filePath -Force
				}

				{ ClearTipIdsAlreadySeen } | Should -Not -Throw
			}
		}

		Context 'When the file exists' {
			It 'Should clear all Tip IDs from the file' {
				AppendTipIdToTipIdsAlreadySeen -TipId 'TestTipId'

				ClearTipIdsAlreadySeen

				$tipIdsAlreadySeen = ReadTipIdsAlreadySeenOrDefault
				$tipIdsAlreadySeen.Count | Should -Be 0
			}

			It 'Should not throw an error if the file is already empty' {
				ClearTipIdsAlreadySeen

				{ ClearTipIdsAlreadySeen } | Should -Not -Throw
			}
		}
	}
}
