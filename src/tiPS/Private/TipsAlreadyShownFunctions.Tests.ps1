using module './../tiPS.psm1'

InModuleScope -ModuleName tiPS { # Must use InModuleScope to call private functions of the module.
	Describe 'Calling RemoveTipsAlreadyShown' {
		BeforeAll {
			function CloneTip([tiPS.PowerShellTip] $tip)
			{
				[tiPS.PowerShellTip] $newTip = [tiPS.PowerShellTip]::new()
				$newTip.CreatedDate = $tip.CreatedDate
				$newTip.Title = $tip.Title
				$newTip.TipText = $tip.TipText
				$newTip.Example = $tip.Example
				$newTip.Urls = $tip.Urls
				$newTip.Category = $tip.Category
				$newTip.ExpiryDate = $tip.ExpiryDate
				$newTip.Author = $tip.Author
				return $newTip
			}
		}

		BeforeEach {
			# Use a temp configuration data directory instead of reading/overwriting the current user's configuration.
			Mock -CommandName Get-TiPSDataDirectoryPath -MockWith {
				[string] $directoryPath = "$TestDrive/tiPS" # Use $TestDrive variable so .NET methods can resolve the path.
				if (-not (Test-Path -Path $directoryPath -PathType Container))
				{
					New-Item -Path $directoryPath -ItemType Directory -Force > $null
				}
				return $directoryPath
			}

			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-01-15')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.Category = 'Community'
			$validTip.ExpiryDate = [DateTime]::MaxValue
			$validTip.Author = 'Author Name'

			# Clone our valid tip to make multiple instances.
			[tiPS.PowerShellTip] $testTip1 = CloneTip -tip $validTip
			[tiPS.PowerShellTip] $testTip2 = CloneTip -tip $validTip
			[tiPS.PowerShellTip] $testTip3 = CloneTip -tip $validTip
			$testTip1.Title = 'Tip 1'
			$testTip2.Title = 'Tip 2'
			$testTip3.Title = 'Tip 3'

			[System.Collections.Specialized.OrderedDictionary] $testTips = [System.Collections.Specialized.OrderedDictionary]::new()
			$testTips.Add($testTip1.Id, $testTip1)
			$testTips.Add($testTip2.Id, $testTip2)
			$testTips.Add($testTip3.Id, $testTip3)
			$testTips.Count | Should -Be 3 # This is here to eliminate the PSScriptAnalyzer warning about unused variables.

			ClearTipIdsAlreadyShown
		}

		It 'Should remove a tip that has already been shown' {
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip1.Id

			RemoveTipsAlreadyShown -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 2
		}

		It 'Should remove multiple tips that have already been shown' {
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip1.Id
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip2.Id

			RemoveTipsAlreadyShown -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Not -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 1
		}

		It 'Should remove all of the tips if they have all been shown' {
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip1.Id
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip2.Id
			AppendTipIdToTipIdsAlreadyShown -TipId $testTip3.Id

			RemoveTipsAlreadyShown -Tips $testTips

			$testTips.Keys | Should -Not -Contain $testTip1.Id
			$testTips.Keys | Should -Not -Contain $testTip2.Id
			$testTips.Keys | Should -Not -Contain $testTip3.Id
			$testTips.Count | Should -Be 0
		}

		It 'Should not remove any tips if none have already been shown' {
			RemoveTipsAlreadyShown -Tips $testTips

			$testTips.Keys | Should -Contain $testTip1.Id
			$testTips.Keys | Should -Contain $testTip2.Id
			$testTips.Keys | Should -Contain $testTip3.Id
			$testTips.Count | Should -Be 3
		}
	}

	Describe 'Calling ClearTipIdsAlreadyShown' {
		BeforeEach {
			# Use a temp configuration data directory instead of reading/overwriting the current user's configuration.
			Mock -CommandName Get-TiPSDataDirectoryPath -MockWith {
				[string] $directoryPath = "$TestDrive/tiPS" # Use $TestDrive variable so .NET methods can resolve the path.
				if (-not (Test-Path -Path $directoryPath -PathType Container))
				{
					New-Item -Path $directoryPath -ItemType Directory -Force > $null
				}
				return $directoryPath
			}
		}

		Context 'When the file does not exist' {
			It 'Should not throw an exception' {
				[string] $filePath = GetTipIdsAlreadyShownFilePath
				if (Test-Path -Path $filePath -PathType Leaf)
				{
					Remove-Item -Path $filePath -Force
				}

				{ ClearTipIdsAlreadyShown } | Should -Not -Throw
			}
		}

		Context 'When the file exists' {
			It 'Should clear all Tip IDs from the file' {
				AppendTipIdToTipIdsAlreadyShown -TipId 'TestTipId'

				ClearTipIdsAlreadyShown

				$tipIdsAlreadyShown = ReadTipIdsAlreadyShownOrDefault
				$tipIdsAlreadyShown.Count | Should -Be 0
			}

			It 'Should not throw an error if the file is already empty' {
				ClearTipIdsAlreadyShown

				{ ClearTipIdsAlreadyShown } | Should -Not -Throw
			}
		}
	}
}
