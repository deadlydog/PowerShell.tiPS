BeforeAll {
	. "$PSScriptRoot\..\Classes\Configuration.ps1"
	. "$PSScriptRoot\ModuleUpdateFunctions.ps1"
}

Describe 'StartModuleUpdateIfNeeded' {
	BeforeEach {
		Mock GetModulesLastUpdateDateFilePath { return 'TestDrive:\ModulesLastUpdateDate.txt' }
		Mock UpdateModule {} -Verifiable
	}

	Context 'When the AutoUpdateCadence is Never' {
		It 'Should not update the module' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Never

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 0 -Exactly
		}
	}

	Context 'When the AutoUpdateCadence is Daily' {
		It 'Should update the module if the last update was more than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Daily
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-2))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 1 day ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Daily
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddHours(-12))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 0 -Exactly
		}
	}

	Context 'When the AutoUpdateCadence is Weekly' {
		It 'Should update the module if the last update was more than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Weekly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-8))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 7 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Weekly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-6))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 0 -Exactly
		}
	}

	Context 'When the AutoUpdateCadence is BiWeekly' {
		It 'Should update the module if the last update was more than 14 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-15))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 14 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-13))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 0 -Exactly
		}
	}

	Context 'When the AutoUpdateCadence is Monthly' {
		It 'Should update the module if the last update was more than 30 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Monthly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-31))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 1 -Exactly
		}

		It 'Should not update the module if the last update was less than 30 days ago' {
			$config = [tiPS.Configuration]::new()
			$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Monthly
			WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.AddDays(-29))

			StartModuleUpdateIfNeeded -Config $config

			Assert-MockCalled UpdateModule -Times 0 -Exactly
		}
	}
}
