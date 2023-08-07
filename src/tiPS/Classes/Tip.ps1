class Tip
{
	[string] $Id
	[string] $Title
	[string] $TipText
	[string] $Example
	[string[]] $Urls
	[Version] $MinPowerShellVersion
	[Tags[]] $Tags

	Tip()
	{
		$this.Id = [string]::Empty
		$this.Title = [string]::Empty
		$this.TipText = [string]::Empty
		$this.Example = [string]::Empty
		$this.Urls = @()
		$this.MinPowerShellVersion = [Version]::new(0, 0)
		$this.Tags = @()
	}

	[void] Validate()
	{
		if ([string]::IsNullOrWhiteSpace($this.Id))
		{
			throw [System.ArgumentException]::new('The Id property must be set.')
		}

		if ($this.Id.Contains(' '))
		{
			throw [System.ArgumentException]::new("The Id property value '$($this.Id)' cannot contain spaces. Use PascalCase.")
		}

		if ([string]::IsNullOrWhiteSpace($this.Title))
		{
			throw [System.ArgumentException]::new('The Title property must be set.')
		}

		if ([string]::IsNullOrWhiteSpace($this.TipText))
		{
			throw [System.ArgumentException]::new('The TipText property must be set.')
		}

		if ($this.Urls -and $this.Urls.Length -gt 3)
		{
			throw [System.ArgumentException]::new('You may only provide up to 3 Urls.')
		}

		foreach ($url in $this.Urls)
		{
			if ([string]::IsNullOrWhiteSpace($url))
			{
				throw [System.ArgumentException]::new('The Urls property must not contain null or empty values.')
			}

			if (-not ($url.StartsWith('http://') -or $url.StartsWith('https://')))
			{
				throw [System.ArgumentException]::new("The Urls property value '$url' must start with 'http://' or 'https://'.")
			}
		}
	}
}

# TODO: Move enum to it's own file: https://stackoverflow.com/questions/69097932/include-enums-from-another-file
enum Tags
{
	Excel
	FileSystem
	Module
	Script
	Social
	Syntax
	Terminal
}
