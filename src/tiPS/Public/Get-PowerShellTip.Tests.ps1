using module .\..\tiPS.psm1

Describe 'Get-PowerShellTip' {
	Context 'Given no parameters' {
		It 'Should return a tip' {
			$tip = Get-PowerShellTip
			$tip | Should -Not -BeNullOrEmpty
		}
	}
}

Describe 'Initializing the module to load up all defined tips' {
	It 'Should load all of the tips successfully' {
		[string] $powerShellTipsDirectoryPath = Resolve-Path "$PSScriptRoot\..\PowerShellTips"
		[int] $numberOfTipsFiles = Get-ChildItem -Path $powerShellTipsDirectoryPath -Filter '*.ps1' |
			Measure-Object |
			Select-Object -ExpandProperty Count

		[int] $numberOfTipsLoaded = (Get-PowerShellTip -All).Count

		$numberOfTipsLoaded | Should -Be $numberOfTipsFiles
	}
}
