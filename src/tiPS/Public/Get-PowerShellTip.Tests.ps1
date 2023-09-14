using module './../tiPS.psm1'

Describe 'Get-PowerShellTip' {
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
