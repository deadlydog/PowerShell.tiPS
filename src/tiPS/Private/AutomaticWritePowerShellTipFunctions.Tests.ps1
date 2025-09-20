using module '.\..\tiPS.psm1'

InModuleScope -ModuleName tiPS { # Must use InModuleScope to call private functions of the module.
	Describe 'Calling WriteAutomaticPowerShellTipIfNeeded' {
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

		Context 'When the WritePowerShellTipCadence is Weekly' {
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

		Context 'When the WritePowerShellTipCadence is Biweekly' {
			It 'Should update the module if the last update was more than 14 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Biweekly
				WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-15))

				WriteAutomaticPowerShellTipIfNeeded -Config $config

				Assert-MockCalled WriteAutomaticPowerShellTip -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 14 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Biweekly
				WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-13))

				WriteAutomaticPowerShellTipIfNeeded -Config $config

				Assert-MockCalled WriteAutomaticPowerShellTip -Times 0 -Exactly
			}
		}

		Context 'When the WritePowerShellTipCadence is Monthly' {
			It 'Should update the module if the last update was more than 30 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Monthly
				WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-31))

				WriteAutomaticPowerShellTipIfNeeded -Config $config

				Assert-MockCalled WriteAutomaticPowerShellTip -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 30 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Monthly
				WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate ([DateTime]::Now.Date.AddDays(-29))

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

	Describe 'Calling WriteLastAutomaticTipWrittenDate' {
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

		It 'Should write the date, and only the date, to the file' {
			$today = [DateTime]::Now.Date
			WriteLastAutomaticTipWrittenDate -LastAutomaticTipWrittenDate $today

			$lastAutomaticTipWrittenDate = Get-Content -Path (GetLastAutomaticTipWrittenDateFilePath)
			$lastAutomaticTipWrittenDate | Should -Be $today
		}
	}
}
