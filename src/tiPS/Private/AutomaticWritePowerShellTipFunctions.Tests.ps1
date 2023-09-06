BeforeAll {
	. "$PSScriptRoot\..\Classes\Configuration.ps1"
	. "$PSScriptRoot\AutomaticWritePowerShellTipFunctions.ps1"
}

Describe 'Calling WriteAutomaticPowerShellTipIfNeeded' {
	BeforeEach {
		Mock GetLastAutomaticTipWrittenDateFilePath { return 'TestDrive:\LastAutomaticTipWrittenDate.txt' }
		Mock WriteAutomaticPowerShellTip {} -Verifiable
	}

	Context 'When the WritePowerShellTipCadence is Never' {
		It 'Should not show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Never

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
		}
	}

	Context 'When the WritePowerShellTipCadence is EveryStartup' {
		It 'Should show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::EveryStartup
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-2))

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 1 -Exactly
		}
	}

	Context 'When the WritePowerShellTipCadence is Daily' {
		It 'Should update the module if the last update was more than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Daily
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-2))

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Daily
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date)

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
		}
	}

	Context 'When the ShowPowerShellTipCandence is Weekly' {
		It 'Should update the module if the last update was more than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Weekly
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-8))

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Weekly
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-6))

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
		}
	}
}
