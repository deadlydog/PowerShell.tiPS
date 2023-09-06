BeforeAll {
	. "$PSScriptRoot\..\Classes\Configuration.ps1"
	. "$PSScriptRoot\AutomaticWritePowerShellTipFunctions.ps1"
}

Describe 'Calling ShowAutomaticPowerShellTipIfNeeded' {
	BeforeEach {
		Mock GetLastAutomaticTipShownDateFilePath { return 'TestDrive:\LastAutomaticTipShownDate.txt' }
		Mock ShowAutomaticPowerShellTip {} -Verifiable
	}

	Context 'When the ShowPowerShellTipCadence is Never' {
		It 'Should not show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::Never

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 0 -Exactly
		}
	}

	Context 'When the ShowPowerShellTipCadence is EveryStartup' {
		It 'Should show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::EveryStartup
			WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate ([DateTime]::Now.Date.AddDays(-2))

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 1 -Exactly
		}
	}

	Context 'When the ShowPowerShellTipCadence is Daily' {
		It 'Should update the module if the last update was more than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::Daily
			WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate ([DateTime]::Now.Date.AddDays(-2))

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::Daily
			WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate ([DateTime]::Now.Date)

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 0 -Exactly
		}
	}

	Context 'When the ShowPowerShellTipCandence is Weekly' {
		It 'Should update the module if the last update was more than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::Weekly
			WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate ([DateTime]::Now.Date.AddDays(-8))

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoShowPowerShellTipCadence = [tiPS.ShowPowerShellTipCadence]::Weekly
			WriteLastAutomaticTipShownDate -LastAutomaticTipShownDate ([DateTime]::Now.Date.AddDays(-6))

			ShowAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled ShowAutomaticPowerShellTip -Times 0 -Exactly
		}
	}
}
