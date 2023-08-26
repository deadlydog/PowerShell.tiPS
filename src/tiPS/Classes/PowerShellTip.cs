using System;

namespace tiPS
{
	// Ideally the enum would be in a separate file, but then we have to deal with writing assemblies to disk
	// in order to load PowerShell types from 2 different files, so just define everything in a single file
	// here for now: https://stackoverflow.com/a/20749076/602585
	public enum TipCategory
	{
		Community, // Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
		Editor, // Editor tips and extensions. e.g. VSCode, ISE, etc.
		Module, // Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
		Syntax, // Syntax tips. e.g. splatting, pipeline, etc.
		Terminal, // Terminal shortcuts and tips. e.g. PSReadLine, ConEmu, etc.
		Other // Tips that don't fit into any of the above categories.
	}

	public class PowerShellTip
	{
		public string Id { get; set; }
		public DateTime CreatedDate { get; set; }
		public string Title { get; set; }
		public string TipText { get; set; }
		public string Example { get; set; }
		public string[] Urls { get; set; }
		public string MinPowerShellVersion { get; set; } // Use a string because System.Version is not deserialized correctly from JSON, and it's a bit more user friendly when specifying the version.
		public TipCategory Category { get; set; }

		public PowerShellTip()
		{
			Id = string.Empty;
			CreatedDate = DateTime.MinValue;
			Title = string.Empty;
			TipText = string.Empty;
			Example = string.Empty;
			Urls = Array.Empty<string>();
			MinPowerShellVersion = string.Empty;
			Category = TipCategory.Other;
		}

		public void Validate()
		{
			if (string.IsNullOrWhiteSpace(Id))
			{
				throw new System.ArgumentException("The Id property must be set.");
			}

			if (CreatedDate == DateTime.MinValue)
			{
				throw new System.ArgumentException("The CreatedDate property must be set.");
			}

			if (Id.Contains(' '))
			{
				throw new System.ArgumentException($"The Id property value '{Id}' cannot contain spaces. Use PascalCase.");
			}

			if (string.IsNullOrWhiteSpace(Title))
			{
				throw new System.ArgumentException("The Title property must be set.");
			}

			if (string.IsNullOrWhiteSpace(TipText))
			{
				throw new System.ArgumentException("The TipText property must be set.");
			}

			if (Urls != null && Urls.Length > 3)
			{
				throw new System.ArgumentException("You may only provide up to 3 Urls.");
			}

			foreach (var url in Urls)
			{
				if (string.IsNullOrWhiteSpace(url))
				{
					throw new System.ArgumentException("The Urls property must not contain null or empty values.");
				}

				bool urlStartsWithHttp = url.StartsWith("http://") || url.StartsWith("https://");
				if (!urlStartsWithHttp)
				{
					throw new System.ArgumentException($"The Urls property value '{url}' must start with 'http://' or 'https://'.");
				}

				Uri uri;
				bool isValidUrl = Uri.TryCreate(url, UriKind.Absolute, out uri);
				if (!isValidUrl)
				{
					throw new System.ArgumentException($"The Urls property value '{url}' is not a valid URL.");
				}
			}

			if (!string.IsNullOrWhiteSpace(MinPowerShellVersion))
			{
				Version version;
				bool isValidVersionNumber = Version.TryParse(MinPowerShellVersion, out version);
				if (!isValidVersionNumber)
				{
					throw new System.ArgumentException($"The MinPowerShellVersion property value '{MinPowerShellVersion}' is not a valid version number.");
				}
			}
		}
	}
}
