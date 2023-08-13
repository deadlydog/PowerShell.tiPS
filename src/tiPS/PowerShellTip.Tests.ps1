using module .\tiPS.psm1

Describe 'Validating a PowerShellTip' {
	Context 'Given a PowerShellTip has invalid properties' {
		BeforeEach {
			[PowerShellTip] $validTip = [PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Tags = @('Excel', 'Module')
		}

		It 'Should throw an error when no ID is supplied' {
			[PowerShellTip] $tip = $validTip
			$tip.Id = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the CreatedDate has not been set' {
			[PowerShellTip] $tip = $validTip
			$tip.CreatedDate = [DateTime]::MinValue
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the ID contains spaces' {
			[PowerShellTip] $tip = $validTip
			$tip.Id = 'The ID should not contain spaces'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no Title is supplied' {
			[PowerShellTip] $tip = $validTip
			$tip.Title = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no TipText is supplied' {
			[PowerShellTip] $tip = $validTip
			$tip.TipText = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when more than 3 URLs are supplied' {
			[PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'https://Url3.com', 'https://Url4.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a URL does not start with http:// or https://' {
			[PowerShellTip] $tip = $validTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'Url3.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid MinPowerShellVersion is supplied' {
			[PowerShellTip] $tip = $validTip
			$tip.MinPowerShellVersion = 'Not a valid version'
			{ $tip.Validate() } | Should -Throw
		}
	}

	Context 'Given a PowerShellTip has all valid properties' {
		BeforeEach {
			[PowerShellTip] $validTip = [PowerShellTip]::new()
			$validTip.Id = "TipId"
			$validTip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$validTip.Title = 'Title of the tip'
			$validTip.TipText = 'Tip Text'
			$validTip.Example = 'Example'
			$validTip.Urls = @('https://Url1.com', 'http://Url2.com')
			$validTip.MinPowerShellVersion = '5.1'
			$validTip.Tags = @('Excel', 'Module')
		}

		It 'Should not throw an error when all properties are valid' {
			[PowerShellTip] $tip = $validTip
			{ $tip.Validate() } | Should -Not -Throw
		}
	}
}
