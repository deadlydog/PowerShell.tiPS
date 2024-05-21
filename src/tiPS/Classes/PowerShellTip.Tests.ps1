using module '.\..\tiPS.psm1'

Describe 'Trimming all tip properties' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given none of the properties need whitespace trimmed' {
		It 'Should not change any of the properties' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			[string] $title = 'Title of the tip'
			[string] $tipText = 'Tip Text'
			[string] $example = 'Example'
			[string[]] $urls = @('https://Url1.com', 'http://Url2.com')
			[string] $author = 'Author Name'
			$tip.Title = $title
			$tip.TipText = $tipText
			$tip.Example = $example
			$tip.Urls = $urls
			$tip.Author = $author

			{ $tip.TrimAllProperties() } | Should -Not -Throw

			$tip.Title | Should -Be $title
			$tip.TipText | Should -Be $tipText
			$tip.Example | Should -Be $example
			$tip.Urls | Should -Be $urls
			$tip.Author | Should -Be $author
		}

		It 'Should not change any of the properties when an Author is not provided' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			[string] $title = 'Title of the tip'
			[string] $tipText = 'Tip Text'
			[string] $example = 'Example'
			[string[]] $urls = @('https://Url1.com', 'http://Url2.com')
			[string] $author = ''
			$tip.Title = $title
			$tip.TipText = $tipText
			$tip.Example = $example
			$tip.Urls = $urls
			$tip.Author = $author

			{ $tip.TrimAllProperties() } | Should -Not -Throw

			$tip.Title | Should -Be $title
			$tip.TipText | Should -Be $tipText
			$tip.Example | Should -Be $example
			$tip.Urls | Should -Be $urls
			$tip.Author | Should -Be $author
		}
	}

	Context 'Given the properties need whitespace trimmed' {
		It 'Should trim the leading and trailing whitespace from all of the properties' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			[string] $title = ' Title of the tip '
			[string] $expectedTitle = 'Title of the tip'
			[string] $tipText = '	Tip Text	'
			[string] $expectedTipText = 'Tip Text'
			[string] $example = ' Example'
			[string] $expectedExample = 'Example'
			[string[]] $urls = @('https://Url1.com   ', '   http://Url2.com')
			[string[]] $expectedUrls = @('https://Url1.com', 'http://Url2.com')
			[string] $author = ' Author Name '
			[string] $expectedAuthor = 'Author Name'
			$tip.Title = $title
			$tip.TipText = $tipText
			$tip.Example = $example
			$tip.Urls = $urls
			$tip.Author = $author

			{ $tip.TrimAllProperties() } | Should -Not -Throw

			$tip.Title | Should -Be $expectedTitle
			$tip.TipText | Should -Be $expectedTipText
			$tip.Example | Should -Be $expectedExample
			$tip.Urls | Should -Be $expectedUrls
			$tip.Author | Should -Be $expectedAuthor
		}
	}
}

Describe 'Validating a PowerShellTip' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given the PowerShellTip has invalid properties' {
		It 'Should throw an error when the CreatedDate has not been set' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.CreatedDate = [DateTime]::MinValue
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no Title is supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Title = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the Title is longer than 75 characters' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Title = 'The maximum number of characters allowed in the title is 75, but this one is 91 characters.'
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when no TipText is supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.TipText = ''
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when more than 3 URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'https://Url3.com', 'https://Url4.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when a URL does not start with http:// or https://' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com', 'Url3.com')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when an invalid Category is supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			{ $tip.Category = 'InvalidCategory' } | Should -Throw
		}

		It 'Should throw an error when the ExpiryDate is before the CreatedDate' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.ExpiryDate = [DateTime]::Parse('2020-01-15')
			{ $tip.Validate() } | Should -Throw
		}

		It 'Should throw an error when the Author is the default template value' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Author = 'Your name and/or username'
			{ $tip.Validate() } | Should -Throw
		}
	}

	Context 'Given the PowerShellTip has all valid properties' {
		It 'Should not throw an error when all properties are valid' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			{ $tip.Validate() } | Should -Not -Throw
		}
	}
}

Describe 'Getting the Id property' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given the PowerShellTip properties are valid and have been specified' {
		It 'Should create the Id properly from the other property values' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.CreatedDate = [DateTime]::Parse('2023-07-16')
			$tip.Title = 'Title of the tip'
			$tip.Id | Should -Be '2023-07-16-title-of-the-tip'
		}

		It 'Should remove any special characters as expected' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.CreatedDate = [DateTime]::Parse('2023-01-22')
			$tip.Title = 'Title with a colon: [brackets] (parentheses) and other special characters!@#$%^&*()_+{}|:"<>?~`'
			$tip.Id | Should -Be '2023-01-22-title-with-a-colon-brackets-parentheses-and-other-special-characters'
		}
	}
}

Describe 'Checking if an Example is provided' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given the PowerShellTip does have an example' {
		It 'Should return true' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Example = 'Example'
			$tip.ExampleIsProvided | Should -BeTrue
		}
	}

	Context 'Given the PowerShellTip does not have an example' {
		It 'Should return false' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Example = ''
			$tip.ExampleIsProvided | Should -BeFalse
		}

		It 'Should return false when the example is null' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Example = $null
			$tip.ExampleIsProvided | Should -BeFalse
		}
	}
}

Describe 'Checking if URLs are provided' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given the PowerShellTip has URLs' {
		It 'Should return true when URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Urls = @('https://Url1.com', 'http://Url2.com')
			$tip.UrlsAreProvided | Should -BeTrue
		}
	}

	Context 'Given the PowerShellTip does not have URLs' {
		It 'Should return false when no URLs are supplied' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Urls = @()
			$tip.UrlsAreProvided | Should -BeFalse
		}

		It 'Should return false when the URLs array is null' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Urls = $null
			$tip.UrlsAreProvided | Should -BeFalse
		}
	}
}

Describe 'Checking if an Author is provided' {
	BeforeEach {
		[tiPS.PowerShellTip] $ValidTip = [tiPS.PowerShellTip]::new()
		$ValidTip.CreatedDate = [DateTime]::Parse('2023-07-16')
		$ValidTip.Title = 'Title of the tip'
		$ValidTip.TipText = 'Tip Text'
		$ValidTip.Example = 'Example'
		$ValidTip.Urls = @('https://Url1.com', 'http://Url2.com')
		$ValidTip.Category = 'Community'
		$ValidTip.ExpiryDate = [DateTime]::MaxValue
		$ValidTip.Author = 'Author Name'
	}

	Context 'Given the PowerShellTip does have an Author' {
		It 'Should return true' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Author = 'Author Name'
			$tip.AuthorIsProvided | Should -BeTrue
		}
	}

	Context 'Given the PowerShellTip does not have an Author' {
		It 'Should return false' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Author = ''
			$tip.AuthorIsProvided | Should -BeFalse
		}

		It 'Should return false when the author is null' {
			[tiPS.PowerShellTip] $tip = $ValidTip
			$tip.Author = $null
			$tip.AuthorIsProvided | Should -BeFalse
		}
	}
}
