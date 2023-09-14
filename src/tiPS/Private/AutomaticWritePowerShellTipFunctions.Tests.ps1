BeforeAll {
	# Add the class types directly instead of importing the module, since all we need are the classes.
	Add-Type -Path "$PSScriptRoot/../Classes/tiPSClasses.dll"
	. "$PSScriptRoot/AutomaticWritePowerShellTipFunctions.ps1"
}

Describe 'Calling WriteAutomaticPowerShellTipIfNeeded' {
	BeforeEach {
		Mock -CommandName GetLastAutomaticTipWrittenDateFilePath -MockWith {
			# We have to use GetUnresolvedProviderPathFromPSPath because the File.ReadAllText method cannot read from the TestDrive provider, and we cannot use Resolve-Path because the file does not exist yet.
			return $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('TestDrive:/LastAutomaticTipWrittenDate.txt')
		}
		Mock -CommandName WriteAutomaticPowerShellTip -MockWith {} -Verifiable
		Mock -CommandName TestPowerShellSessionIsInteractive -MockWith { return $true }
	}

	Context 'When the WritePowerShellTipCadence is Never' {
		It 'Should not show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Never

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
		}
	}

	Context 'When the WritePowerShellTipCadence is EverySession' {
		It 'Should show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::EverySession
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

	Context 'When the PowerShell session is not interactive' {
		BeforeEach {
			Mock -CommandName TestPowerShellSessionIsInteractive -MockWith { return $false }
		}

		It 'Should not show a tip' {
			$config = [tiPS.Configuration]::new()
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::EverySession

			WriteAutomaticPowerShellTipIfNeeded -Config $config

			Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
		}
	}
}
