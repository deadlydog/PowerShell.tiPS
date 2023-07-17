class Tip
{
	[string] $Id
	[string] $Title
	[string] $TipText
	[string] $Example
	[string[]] $Urls
	[Version] $MinPowerShellVersion
	[Tags[]] $Tags
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
