using System;

namespace tiPS
{
	public enum TipCategory
	{
		Community, // Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
		Editor, // Editor tips and extensions. e.g. VSCode, ISE, etc.
		Module, // Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
		NativeCmdlet, // Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
		Performance, // Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
		Security, // Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
		Syntax, // Syntax tips. e.g. splatting, pipeline, etc.
		Terminal, // Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
		Other // Tips that don't fit into any of the other categories.
	}

	public class PowerShellTip
	{
		public DateTime CreatedDate { get; set; }
		public string Title { get; set; }
		public string TipText { get; set; }
		public string Example { get; set; }
		public string[] Urls { get; set; }
		public TipCategory Category { get; set; }

		public PowerShellTip()
		{
			CreatedDate = DateTime.MinValue;
			Title = string.Empty;
			TipText = string.Empty;
			Example = string.Empty;
			Urls = Array.Empty<string>();
			Category = TipCategory.Other;
		}

		public string Id
		{
			get
			{
				string id = CreatedDate.ToString("yyyy-MM-dd-") + Title.ToLower().Replace(" ", "-");
				string idWithoutSpecialCharacters = System.Text.RegularExpressions.Regex.Replace(id, "[^a-zA-Z0-9-]", "");
				return idWithoutSpecialCharacters;
			}
		}

		public bool ExampleIsProvided
		{
			get { return !string.IsNullOrWhiteSpace(Example); }
		}

		public bool UrlsAreProvided
		{
			get { return Urls != null && Urls.Length > 0; }
		}

		public void TrimAllProperties()
		{
			Title = Title.Trim();
			TipText = TipText.Trim();
			Example = Example.Trim();
			for (int i = 0; i < Urls.Length; i++)
			{
				Urls[i] = Urls[i].Trim();
			}
		}

		public void Validate()
		{
			if (CreatedDate == DateTime.MinValue)
			{
				throw new ArgumentException("The CreatedDate property must be set.");
			}

			if (string.IsNullOrWhiteSpace(Title))
			{
				throw new ArgumentException("The Title property must be set.");
			}

			if (Title.Length > 75)
			{
				throw new ArgumentException("The Title property value must be 75 characters or less. The current title's length is " + Title.Length + " characters.");
			}

			if (string.IsNullOrWhiteSpace(TipText))
			{
				throw new ArgumentException("The TipText property must be set.");
			}

			if (UrlsAreProvided && Urls.Length > 3)
			{
				throw new ArgumentException("You may only provide up to 3 Urls.");
			}

			foreach (var url in Urls)
			{
				if (string.IsNullOrWhiteSpace(url))
				{
					throw new ArgumentException("The Urls property must not contain null or empty values.");
				}

				bool urlStartsWithHttp = url.StartsWith("http://") || url.StartsWith("https://");
				if (!urlStartsWithHttp)
				{
					throw new ArgumentException("The Urls property value '" + url + "' must start with 'http://' or 'https://'.");
				}

				Uri uri;
				bool isValidUrl = Uri.TryCreate(url, UriKind.Absolute, out uri);
				if (!isValidUrl)
				{
					throw new ArgumentException("The Urls property value '" + url + "' is not a valid URL.");
				}
			}
		}
	}
}
