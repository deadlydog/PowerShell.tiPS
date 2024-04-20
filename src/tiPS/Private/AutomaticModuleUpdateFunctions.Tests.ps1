using module '.\..\tiPS.psm1'

InModuleScope -ModuleName tiPS { # Must use InModuleScope to call private functions of the module.
	Describe 'Calling StartModuleUpdateIfNeeded' {
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
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-2))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 1 day ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Daily
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date)

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 0 -Exactly
			}
		}

		Context 'When the AutoUpdateCadence is Weekly' {
			It 'Should update the module if the last update was more than 7 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Weekly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-8))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 7 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Weekly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-6))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 0 -Exactly
			}
		}

		Context 'When the AutoUpdateCadence is BiWeekly' {
			It 'Should update the module if the last update was more than 14 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-15))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 14 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::BiWeekly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-13))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 0 -Exactly
			}
		}

		Context 'When the AutoUpdateCadence is Monthly' {
			It 'Should update the module if the last update was more than 30 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Monthly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-31))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 1 -Exactly
			}

			It 'Should not update the module if the last update was less than 30 days ago' {
				$config = [tiPS.Configuration]::new()
				$config.AutoUpdateCadence = [tiPS.ModuleAutoUpdateCadence]::Monthly
				WriteModulesLastUpdateDate -ModulesLastUpdateDate ([DateTime]::Now.Date.AddDays(-29))

				StartModuleUpdateIfNeeded -Config $config

				Assert-MockCalled UpdateModule -Times 0 -Exactly
			}
		}
	}

	Describe 'Updating the module' {
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

			# Update-Module is called from a background job, and we cannot mock calls inside a background job's scriptblock,
			# so the best we can do to check if Update-Module was called is to mock Start-Job and ensure it was called.
			Mock Start-Job {} -Verifiable
		}

		It 'Should update the module in a background job' {
			UpdateModule

			Assert-MockCalled Start-Job -Times 1 -Exactly
		}

		It 'Should write the current date to the modules last updated date text file' {
			UpdateModule

			[DateTime] $today = [DateTime]::Now.Date
			[DateTime] $updatedDate = ReadModulesLastUpdateDateOrDefault
			$updatedDate | Should -Be $today
		}
	}

	Describe 'Calling WriteModulesLastUpdateDate' {
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
			WriteModulesLastUpdateDate -ModulesLastUpdateDate $today

			$modulesLastUpdateDate = Get-Content -Path (GetModulesLastUpdateDateFilePath)
			$modulesLastUpdateDate | Should -Be $today
		}
	}
}
