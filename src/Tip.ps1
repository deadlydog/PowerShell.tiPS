class Tip
{
	[string] $Id
	[string] $Title
	[string] $TipText
	[string] $Example
	[string[]] $Urls
	[Version] $MinPowerShellVersion
	[Tags[]] $Tags

	[void] Validate()
	{
		if ([string]::IsNullOrWhiteSpace($this.Id))
		{
			throw [System.ArgumentException]::new('The Id property must be set.')
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
	}
}

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
