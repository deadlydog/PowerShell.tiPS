using module '.\..\tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Get-PowerShellTip' {
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

		function GetAllTipsFromJsonFile
		{
			[string] $powerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot/../PowerShellTips.json"
			[PSCustomObject[]] $allTips =
				Get-Content -Path $powerShellTipsJsonFilePath |
				ConvertFrom-Json
			return $allTips
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
		It 'Should return all non-expired tips' {
			[PSCustomObject[]] $allTipsFromJsonFile = GetAllTipsFromJsonFile
			[int] $numberOfNonExpiredTipsInJsonFile = $allTipsFromJsonFile |
				Where-Object { $_.ExpiryDate -ge [DateTime]::Today } |
				Measure-Object |
				Select-Object -ExpandProperty Count

			$allTips = Get-PowerShellTip -All

			$allTips | Should -Not -BeNullOrEmpty
			$allTips.Count | Should -Be $numberOfNonExpiredTipsInJsonFile
		}

		It 'Should return the tips ordered by Created Date from oldest to newest' {
			$allTips = Get-PowerShellTip -All

			$allTips | Should -Not -BeNullOrEmpty

			$previousTipDate = [DateTime]::MinValue
			foreach ($tip in $allTips.Values)
			{
				$tip.CreatedDate | Should -BeGreaterOrEqual $previousTipDate
				$previousTipDate = $tip.CreatedDate
			}
		}
	}

	Context 'When piping string IDs to it' {
		It 'Should return the tip with the specified ID' {
			$tip = '2023-07-16-powershell-is-open-source' | Get-PowerShellTip
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}

	Context 'When piping an object with an Id property to it' {
		It 'Should return the tip with the specified ID' {
			$tip = [PSCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Get-PowerShellTip
			$tip.Id | Should -Be '2023-07-16-powershell-is-open-source'
		}
	}

	Context 'Given no parameters and the tip retrieval order specified in the configuration' {
		BeforeAll {
			# Prevent warnings from being thrown when setting the TipRetrievalOrder in the tests because the module is not imported by the PowerShell profile.
			Set-TiPSConfiguration -AutomaticallyUpdateModule Never -AutomaticallyWritePowerShellTip Never
		}

		BeforeEach {
			InModuleScope -ModuleName $ModuleName {
				# Ensure that all tips are available to be selected by Get-PowerShellTip so it can get the oldest or newest one.
				ResetUnshownTips
			}
		}

		It 'Should return the newest tip when the tip retrieval order is NewestFirst' {
			[PSCustomObject[]] $allTipsFromJsonFile = GetAllTipsFromJsonFile
			[DateTime] $newestTipDate = $allTipsFromJsonFile |
				Sort-Object -Property CreatedDate |
				Select-Object -Last 1 -ExpandProperty CreatedDate

			Set-TiPSConfiguration -TipRetrievalOrder NewestFirst

			$tip = Get-PowerShellTip

			$tip.CreatedDate | Should -Be $newestTipDate
		}

		It 'Should return the oldest tip when the tip retrieval order is OldestFirst' {
			[PSCustomObject[]] $allTipsFromJsonFile = GetAllTipsFromJsonFile
			[DateTime] $oldestTipDate = $allTipsFromJsonFile |
				Sort-Object -Property CreatedDate |
				Select-Object -First 1 -ExpandProperty CreatedDate

			Set-TiPSConfiguration -TipRetrievalOrder OldestFirst

			$tip = Get-PowerShellTip

			$tip.CreatedDate | Should -Be $oldestTipDate
		}
	}
}

InModuleScope -ModuleName tiPS { # Must use InModuleScope to access script-level variables of the module.
	Describe 'Get-PowerShellTip in module scope' {
		BeforeAll {
			New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.

			[string] $powerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot\..\PowerShellTips.json"
			[int] $numberOfTipsInJsonFile =
				Get-Content -Path $powerShellTipsJsonFilePath |
					ConvertFrom-Json |
					Measure-Object |
					Select-Object -ExpandProperty Count
			New-Variable -Name TotalNumberOfTips -Value $numberOfTipsInJsonFile -Option Constant -Force
		}

		BeforeEach {
			# Write the configuration to a temp location, instead of overwriting the current user's configuration.
			Mock -ModuleName $ModuleName -CommandName Get-TiPSDataDirectoryPath -MockWith {
				[string] $directoryPath = "$TestDrive/tiPS" # Use $TestDrive variable so .NET methods can resolve the path.
				if (-not (Test-Path -Path $directoryPath -PathType Container))
				{
					New-Item -Path $directoryPath -ItemType Directory -Force > $null
				}
				return $directoryPath
			}

			[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
			$ValidTip.CreatedDate = [DateTime]::Parse('2023-01-15')
			$ValidTip.Title = 'Title of the tip'
			$ValidTip.TipText = 'Tip Text'
			$ValidTip.Example = 'Example'
			$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$ValidTip.Category = 'Community'
			$ValidTip.ExpiryDate = [DateTime]::MaxValue
			$ValidTip.Author = 'Author Name'
		}

		Context 'When all of the tips have been shown' {
			BeforeEach {
				$script:UnshownTips.Clear()
			}

			It 'Should reset the tips script variable to include all tips and return one of them' {
				$tip = Get-PowerShellTip

				$tip | Should -Not -BeNullOrEmpty
				$script:UnshownTips.Count | Should -Be ($TotalNumberOfTips - 1)





				# Temp code for troubleshooting tests on Windows PowerShell.
				[string] $powerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot\..\PowerShellTips.json"
				$content = Get-Content -Path $powerShellTipsJsonFilePath
				[int] $numberOfTipsInJsonFile =
					$content |
						ConvertFrom-Json |
						Measure-Object |
						Select-Object -ExpandProperty Count
				$powerShellTipsJsonFilePath | Should -Be "C:\Users\work\src\tiPS\PowerShellTips.json"
				$content | Should -Be "not actually this"
				$numberOfTipsInJsonFile | Should -Be 48
			}
		}

		Context 'When only one tip is still left to be shown' {
			BeforeEach {
				$script:UnshownTips.Clear()
				$script:UnshownTips.Add($ValidTip.Id, $ValidTip)
			}

			It 'Should return the last tip and reset the unshown tips variable to include all tips' {
				$tip = Get-PowerShellTip

				$tip.Id | Should -Be $ValidTip.Id
				$script:UnshownTips.Count | Should -Be $TotalNumberOfTips
			}
		}
	}
}
