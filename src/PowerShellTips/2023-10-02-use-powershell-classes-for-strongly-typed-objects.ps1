$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-02')

$tip.Title = 'Use PowerShell classes for strongly-typed objects'
$tip.TipText = @'
PowerShell 5.0 introduced classes. Classes allow you to create strongly-typed objects, encapsulating properties and methods. This allows you to keep related data together and to define functions for manipulating the data, allowing for validation if necessary. Classes also allow for inheritance.

There are some caveats to working with classes in PowerShell though:
- If you make changes to the class definition you must reload the PowerShell session for the changes to take effect.
- PowerShell classes defined in modules are not exported when 'Import-Module' is used; Instead the 'using module' syntax must be used.
'@
$tip.Example = @'
class Employee
{
	[string] $FirstName
	[string] $LastName
	[DateTime] $DateOfBirth
	[int] $Salary

	[string] GetFullName()
	{
		return "$this.FirstName $this.LastName"
	}

	[void] IncreaseSalary([int] $amount)
	{
		$this.Salary += $amount
	}
}

$employee = [Employee]::new()
$employee.FirstName = 'John'
$employee.LastName = 'Doe'
$employee.DateOfBirth = [DateTime]::Parse('1983-01-15')
$employee.Salary = 50000
$employee.GetFullName()
$employee.IncreaseSalary(10000)
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes'
	'https://xainey.github.io/2016/powershell-classes-and-concepts/'
	'https://blog.danskingdom.com/PowerShell-class-definition-pros-cons-and-performance-comparison/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
