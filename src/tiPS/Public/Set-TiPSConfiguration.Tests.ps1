using module .\..\tiPS.psm1

BeforeAll {
	New-Variable -Name ModuleName -Value 'tiPS' -Option Constant -Force # Required for mocking public functions called by the module.
}

Describe 'Setting the Configuration' {
	BeforeEach {
		# Write the configuration to a temp location, instead of overwriting the current user's configuration.
		Mock -ModuleName $ModuleName Get-TiPSDataDirectoryPath { return 'TestDrive:\tiPS' }
	}

	Context 'When setting the entire Configuration object' {
		It 'Should set the configuration' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly

			Set-TiPSConfiguration -Configuration $config

			$result = Get-TiPSConfiguration
			$result | Should -Be $config
		}
	}

	Context 'When setting the AutomaticallyUpdateModule property' {
		It 'Should set the property to the proper value when using strongly-typed input' {
			Set-TiPSConfiguration -AutomaticallyUpdateModule ([tiPS.ModuleAutoUpdateCadence]::BiWeekly)

			$result = Get-TiPSConfiguration
			$result.AutoUpdateCadence | Should -Be ([tiPS.ModuleAutoUpdateCadence]::BiWeekly)
		}

		It 'Should set the property to the proper value when using string input' {
			Set-TiPSConfiguration -AutomaticallyUpdateModule Monthly

			$result = Get-TiPSConfiguration
			$result.AutoUpdateCadence | Should -Be Monthly
		}
	}
}
