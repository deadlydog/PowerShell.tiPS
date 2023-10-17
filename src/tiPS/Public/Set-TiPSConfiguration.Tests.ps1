using module './../tiPS.psm1'

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking functions called by the module.
}

Describe 'Setting the Configuration' {
	BeforeEach {
		# Write the configuration to a temp location, instead of overwriting the current user's configuration.
		Mock -ModuleName $ModuleName Get-TiPSDataDirectoryPath { return 'TestDrive:/tiPS' }
		Mock -ModuleName $ModuleName Test-PowerShellProfileImportsTiPS { return $true }
	}

	Context 'When setting the entire Configuration object' {
		It 'Should set the configuration' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
			$config.TipRetrievalOrder = [tiPS.TipRetrievalOrder]::Random

			Set-TiPSConfiguration -Configuration $config

			$result = Get-TiPSConfiguration
			$result | Should -Be $config
		}
	}

	Context 'When setting the AutomaticallyUpdateModule property' {
		It 'Should set the property to the proper value when using strongly-typed input' {
			Set-TiPSConfiguration -AutomaticallyUpdateModule ([tiPS.ModuleAutoUpdateCadence]::Daily)

			$result = Get-TiPSConfiguration
			$result.AutoUpdateCadence | Should -Be ([tiPS.ModuleAutoUpdateCadence]::Daily)
		}

		It 'Should set the property to the proper value when using string input' {
			Set-TiPSConfiguration -AutomaticallyUpdateModule Monthly

			$result = Get-TiPSConfiguration
			$result.AutoUpdateCadence | Should -Be Monthly
		}
	}

	Context 'When setting the AutomaticallyWritePowerShellTip property' {
		It 'Should set the property to the proper value when using strongly-typed input' {
			Set-TiPSConfiguration -AutomaticallyWritePowerShellTip ([tiPS.WritePowerShellTipCadence]::Weekly)

			$result = Get-TiPSConfiguration
			$result.AutoWritePowerShellTipCadence | Should -Be ([tiPS.WritePowerShellTipCadence]::Weekly)
		}

		It 'Should set the property to the proper value when using string input' {
			Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily

			$result = Get-TiPSConfiguration
			$result.AutoWritePowerShellTipCadence | Should -Be Daily
		}
	}

	Context 'When setting the TipRetrievalOrder property' {
		It 'Should set the property to the proper value when using strongly-typed input' {
			Set-TiPSConfiguration -TipRetrievalOrder ([tiPS.TipRetrievalOrder]::OldestFirst)

			$result = Get-TiPSConfiguration
			$result.TipRetrievalOrder | Should -Be ([tiPS.TipRetrievalOrder]::OldestFirst)
		}

		It 'Should set the property to the proper value when using string input' {
			Set-TiPSConfiguration -TipRetrievalOrder NewestFirst

			$result = Get-TiPSConfiguration
			$result.TipRetrievalOrder | Should -Be NewestFirst
		}
	}

	Context 'When piping an object to the function' {
		It 'Should set the configuration when a Configuration object is piped in' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
			$config.AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Weekly

			$config | Set-TiPSConfiguration

			$result = Get-TiPSConfiguration
			$result | Should -Be $config
		}

		It 'Should set the configuration when an object with the same properties as a Configuration object is piped in' {
			$config = @{
				AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Monthly
				AutoWritePowerShellTipCadence = [tiPS.WritePowerShellTipCadence]::Weekly
				TipRetrievalOrder = [tiPS.TipRetrievalOrder]::OldestFirst
			}

			$config | Set-TiPSConfiguration

			$result = Get-TiPSConfiguration
			$result.AutoUpdateCadence | Should -Be ([tiPS.ModuleAutoUpdateCadence]::Monthly)
			$result.AutoWritePowerShellTipCadence | Should -Be ([tiPS.WritePowerShellTipCadence]::Weekly)
			$result.TipRetrievalOrder | Should -Be ([tiPS.TipRetrievalOrder]::OldestFirst)
		}
	}
}
