using module './../tiPS.psm1'

InModuleScope -ModuleName tiPS { # Must use InModuleScope to call private functions of the module.
	Describe 'Calling RemoveTipsAlreadySeen' {
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
			$serializedTip = [System.Management.Automation.PSSerializer]::Serialize($validTip)
			$testTip1 = [System.Management.Automation.PSSerializer]::Deserialize($serializedTip)
			$testTip2 = [System.Management.Automation.PSSerializer]::Deserialize($serializedTip)
			$testTip3 = [System.Management.Automation.PSSerializer]::Deserialize($serializedTip)
			$testTip1.Title = 'Tip 1'
			$testTip2.Title = 'Tip 2'
			$testTip3.Title = 'Tip 3'

			$id1 = $testTip1.Id
			$id2 = $testTip2.Id
			$id3 = $testTip3.Id

			[hashtable] $testTips = @{
				($testTip1.Id) = $testTip1
				($testTip2.Id) = $testTip2
				($testTip3.Id) = $testTip3
			}

			# ClearTipIdsAlreadySeen
		}

		It 'Should remove tips that have already been seen' {
			AppendTipIdToTipIdsAlreadySeen -TipId $testTip1.Id

			RemoveTipsAlreadySeen -Tips $testTips

			$tipHashTable.Keys | Should -Not -Contain $testTip1.Id
			$tipHashTable.Keys | Should -Contain $testTip2.Id
			$tipHashTable.Keys | Should -Contain $testTip3.Id
		}
	}
}
