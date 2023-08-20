# Use C# classes and enums as they provide a better dev and module consumer experience.
# https://blog.danskingdom.com/How-and-where-to-properly-define-classes-and-enums-in-your-PowerShell-modules/
Add-Type -Language CSharp -TypeDefinition @'
	public enum PowerShellTipTag
	{
		Excel,
		FileSystem,
		Module,
		Script,
		Social,
		Syntax,
		Terminal
	}
'@
