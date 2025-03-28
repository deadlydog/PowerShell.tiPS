function New-PowerShellTipFileContents {
	param(
		[Parameter(Mandatory = $true, HelpMessage = 'The date the tip was created. Format: YYYY-MM-DD')]
		[ValidateNotNullOrWhiteSpace()]
		[string] $TipCreatedDate,

		[Parameter(Mandatory = $true, HelpMessage = 'The title of the tip. Must be 75 characters or less.')]
		[ValidateNotNullOrWhiteSpace()]
		[string] $TipTitle,

		[Parameter(Mandatory = $true, HelpMessage = 'The text of the tip.')]
		[ValidateNotNullOrWhiteSpace()]
		[string] $TipText,

		[Parameter(Mandatory = $false, HelpMessage = 'The example code for the tip. Use an empty string if no example is provided.')]
		[string] $TipExample = '',

		[Parameter(Mandatory = $false, HelpMessage = 'The URLs for the tip. Use an empty array if no URLs are provided.')]
		[string[]] $TipUrls = @(),

		[Parameter(Mandatory = $true, HelpMessage = 'The category of the tip. Must be one of the following: Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.')]
		[ValidateSet('Community', 'Editor', 'Module', 'NativeCmdlet', 'Performance', 'Security', 'Syntax', 'Terminal', 'Other')]
		[string] $TipCategory,

		[Parameter(Mandatory = $false, HelpMessage = 'The author of the tip. Use an empty string if no author is provided.')]
		[string] $TipAuthor = '',

		[Parameter(Mandatory = $false, HelpMessage = 'The expiry date of the tip. Format: YYYY-MM-DD. Use an empty string if no expiry date is provided.')]
		[string] $TipExpiryDate = ''
	)

	[string] $tipTemplateFileContents = @"
`$tip = [tiPS.PowerShellTip]::new()
`$tip.CreatedDate = [DateTime]::Parse('$TipCreatedDate')
`$tip.Title = '$($TipTitle.Replace("'", "''"))'
`$tip.TipText = $TipText
`$tip.Example = $TipExample
`$tip.Urls = $TipUrls
`$tip.Category = [tiPS.TipCategory]::$TipCategory # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
`$tip.Author = '$TipAuthor' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#`$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Category meanings:
# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
"@

	return $tipTemplateFileContents
}
