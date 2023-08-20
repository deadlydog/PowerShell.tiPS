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

	Context 'Given a tip ID' {
		It 'Should return the tip with the specified ID' {
			$tip = Get-PowerShellTip -TipId 'PowerShellIsOpenSource'
			$tip.Id | Should -Be 'PowerShellIsOpenSource'
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

Describe 'Initializing the module to load up all defined tips' {
	It 'Should load all of the tips successfully' {
		[string] $powerShellTipsDirectoryPath = Resolve-Path "$PSScriptRoot\..\..\PowerShellTips"
		[int] $numberOfTipsFiles = Get-ChildItem -Path $powerShellTipsDirectoryPath -Filter '*.ps1' |
			Measure-Object |
			Select-Object -ExpandProperty Count

		[int] $numberOfTipsLoaded = (Get-PowerShellTip -All).Count

		$numberOfTipsLoaded | Should -Be $numberOfTipsFiles
	}
}
