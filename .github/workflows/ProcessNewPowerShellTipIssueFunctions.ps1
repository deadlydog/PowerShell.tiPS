function New-PowerShellTipFile {
	param(
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

	Write-Information "Building tiPS C# assemblies and importing module..." -InformationAction Continue
	$buildOutput = . "$PSScriptRoot/../../tools/Helpers/ImportBuiltModule.ps1"

	# Write the build output as Information messages so it doesn't affect the function's return value.
	foreach ($entry in $buildOutput) {
		Write-Information $entry -InformationAction Continue
	}

	# The Tip filename is based on the ID, which is based on the date and title, so load a dummy PowerShellTip to get the filename to use.
	$dummyTip = [tiPS.PowerShellTip]::new()
	$dummyTip.CreatedDate = [DateTime]::Today
	$dummyTip.Title = $TipTitle.Trim()

	[string] $createdDate = $dummyTip.CreatedDate.ToString('yyyy-MM-dd')
	[string] $powerShellTipsFilesDirectoryPath = Resolve-Path -Path "$PSScriptRoot/../../src/PowerShellTips"
	[string] $newTipFileName = $dummyTip.Id + '.ps1'
	[string] $newTipFilePath = Join-Path -Path $powerShellTipsFilesDirectoryPath -ChildPath $newTipFileName

	[string] $newTipFileContent = @"
`$tip = [tiPS.PowerShellTip]::new()
`$tip.CreatedDate = [DateTime]::Parse('$createdDate')
`$tip.Title = '$($TipTitle.Replace("'", "''"))'
`$tip.TipText = $TipText
`$tip.Example = $TipExample
`$tip.Urls = $TipUrls
`$tip.Category = [tiPS.TipCategory]::$TipCategory # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
`$tip.Author = '$TipAuthor' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#`$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
"@

	# If a TipExpiryDate is provided, uncomment the TipExpiryDate line.
	if (-not [string]::IsNullOrWhiteSpace($TipExpiryDate)) {
		[string] $expiryTextToMatch = '$tip.ExpiryDate = [DateTime]::Parse('
		$newTipFileContent = $newTipFileContent.Replace("#$expiryTextToMatch", $expiryTextToMatch)
	}

	Write-Information "Creating new tip file '$newTipFilePath'..." -InformationAction Continue
	Set-Content -Path $newTipFilePath -Value $newTipFileContent -Encoding utf8 -Force

	return $newTipFilePath
}
