# In order for classes and enums to be accessible outside of the module, they must be defined directly in the psm1 file.
# For more info see: https://github.com/deadlydog/PowerShell.Experiment.ClassInModule

class Tip
{
	[string] $Id
	[DateTime] $CreatedDate
	[string] $Title
	[string] $TipText
	[string] $Example
	[string[]] $Urls
	[string] $MinPowerShellVersion # Use a string because System.Version is not deserialized correctly from JSON.
	[Tags[]] $Tags

	Tip()
	{
		$this.Id = [string]::Empty
		$this.CreatedDate = [DateTime]::MinValue
		$this.Title = [string]::Empty
		$this.TipText = [string]::Empty
		$this.Example = [string]::Empty
		$this.Urls = @()
		$this.MinPowerShellVersion = [string]::Empty
		$this.Tags = @()
	}

	[void] Validate()
	{
		if ([string]::IsNullOrWhiteSpace($this.Id))
		{
			throw [System.ArgumentException]::new('The Id property must be set.')
		}

		if ($this.CreatedDate -eq [DateTime]::MinValue)
		{
			throw [System.ArgumentException]::new('The CreatedDate property must be set.')
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

		if (-not [string]::IsNullOrWhiteSpace($this.MinPowerShellVersion))
		{
			[bool] $isValidVersionNumber = [Version]::TryParse($this.MinPowerShellVersion, [ref] $null)
			if (-not $isValidVersionNumber)
			{
				throw [System.ArgumentException]::new("The MinPowerShellVersion property value '$($this.MinPowerShellVersion)' is not a valid version number.")
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


#Requires -Version 5.0
Set-StrictMode -Version Latest

# Import all Private and Public functions from their respective directories.
[string[]] $privateFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Private -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $publicFunctionFilePaths =
	Get-ChildItem -Path $PSScriptRoot\Public -Recurse -Filter '*.ps1' -Exclude '*.Tests.ps1' |
	Select-Object -ExpandProperty FullName

[string[]] $functionFilesToImport = $privateFunctionFilePaths + $publicFunctionFilePaths

$functionFilesToImport | ForEach-Object {
	[string] $filePath = $_

	try
	{
		Write-Debug "Dot-source importing functions/types from file '$filePath'."
		. $_
	}
	catch
	{
		Write-Error "Failed to dot-source import functions/types from file '$filePath': $_"
	}
}

Write-Debug 'Now that all types and functions are imported, initializing the module.'
LoadAllPowerShellTipsFromJsonFile

# Function and Alias exports are defined in the modules manifest (.psd1) file.
