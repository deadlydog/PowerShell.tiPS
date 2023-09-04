BeforeAll {
	. "$PSScriptRoot\PowerShellTip.ps1"
}

Describe 'Validating a PowerShellTip' {
	Context 'Given the PowerShellTip has invalid properties' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should throw an error when the CreatedDate has not been set' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.CreatedDate = [DateTime]::MinValue
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no Title is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Title = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the Title is longer than 75 characters' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Title = 'The maximum number of characters allowed in the title is 75, but this one is 91 characters.'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no TipText is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.TipText = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when more than 3 URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'https://Url3.com', 'https://Url4.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a URL does not start with http:// or https://' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'Url3.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid MinPowerShellVersion is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = 'Not a valid version'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a version with a Build is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1.1'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a version with a Revision is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1.0.1'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid Category is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			{ $tip.Category = 'InvalidCategory' } | Should -Throw
		}
	}

	Context 'Given the PowerShellTip has all valid properties' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should not throw an error when all properties are valid' {
			[tiPS.PowerShellTip] $tip = $validTip
			{ $tip.Validate() } | Should -Not -Throw
		}

		It 'Should not throw an error when the MinPowerShellVersion is 0.0' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '0.0'
			{ $tip.Validate() } | Should -Not -Throw
		}

		It 'Should not throw an error when the MinPowerShellVersion is an empty string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ''
			{ $tip.Validate() } | Should -Not -Throw
		}
	}
}

Describe 'Getting the Id property' {
	Context 'Given the PowerShellTip properties are valid and have been specified' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should create the Id properly from the other property values' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$tip.Title = 'Title of the tip'
			$tip.Id | Should -Be '2023-07-16-title-of-the-tip'
		}

		It 'Should remove any special characters as expected' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.CreatedDate = [DateTime]::Parse('2023-01-22')
			$tip.Title = 'Title with a colon: [brackets] (parentheses) and other special characters!@#$%^&*()_+{}|:"<>?~`'
			$tip.Id | Should -Be '2023-01-22-title-with-a-colon-brackets-parentheses-and-other-special-characters'
		}
	}
}

Describe 'Checking if URLs are provided' {
	Context 'Given the PowerShellTip has URLs' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should return true when URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com')
			$tip.UrlsAreProvided | Should -BeTrue
		}
	}

	Context 'Given the PowerShellTip does not have URLs' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @()
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should return false when no URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = @()
			$tip.UrlsAreProvided | Should -BeFalse
		}

		It 'Should return false when the URLs array is not initialized' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.Urls = $null
			$tip.UrlsAreProvided | Should -BeFalse
		}
	}
}

Describe 'Checking if a MinPowerShellVersion was provided' {
	Context 'Given the PowerShellTip has a MinPowerShellVersion' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Category = 'Community'
		}

		It 'Should return true when a MinPowerShellVersion is supplied' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '5.1'
			$tip.MinPowerShellVersionIsProvided | Should -BeTrue
		}
	}

	Context 'Given the PowerShellTip does not have a MinPowerShellVersion' {
		BeforeEach {
			[tiPS.PowerShellTip] $validTip = [tiPS.PowerShellTip]::new()
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '0.0'
			$validTip.Category = 'Community'
		}

		It 'Should return false when the MinPowerShellVersion is 0.0' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = '0.0'
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}

		It 'Should return false when the MinPowerShellVersion is an empty string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ''
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}

		It 'Should return false when the MinPowerShellVersion is a whitespace string' {
			[tiPS.PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = ' '
			$tip.MinPowerShellVersionIsProvided | Should -BeFalse
		}
	}
}
