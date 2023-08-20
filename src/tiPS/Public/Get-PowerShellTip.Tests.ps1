using module .\..\tiPS.psm1

BeforeAll {
	[string] $PowerShellTipsJsonFilePath = Resolve-Path "$PSScriptRoot\..\PowerShellTips.json"
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
			$tip = Get-PowerShellTip -TipId 'PowerShellIsOpenSource'
			$tip.Id | Should -Be 'PowerShellIsOpenSource'
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
			[int] $numberOfTipsInJsonFile =
			Get-Content -Path $PowerShellTipsJsonFilePath |
				ConvertFrom-Json |
				Measure-Object |
				Select-Object -ExpandProperty Count

			$allTips = Get-PowerShellTip -All

			$allTips | Should -Not -BeNullOrEmpty
			$allTips.Count | Should -Be $numberOfTipsInJsonFile
		}
	}
}
