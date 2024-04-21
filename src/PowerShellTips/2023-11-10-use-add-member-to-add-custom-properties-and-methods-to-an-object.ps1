$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-11-10')
$tip.Title = 'Use Add-Member to add custom properties and methods to an object'
$tip.TipText = @'
The Add-Member cmdlet can be used to add custom properties and methods to an object, whether it is a .NET object or PowerShell object. This can be useful when you want to add additional information to an object, or when you want to add a method to an object to perform some action.

The `Add-Member` cmdlet has a `-MemberType` parameter that can be used to specify the type of member to add. The most common types are `NoteProperty` and `ScriptMethod`. The `NoteProperty` type is used to add a new property to an object, while the `ScriptMethod` type is used to add a method to an object.

The main difference between a calculated property and adding a property to an object with Add-Member is that calculated properties are added to a new output object, while Add-Member modifies the original object.
'@
$tip.Example = @'
# Add a new 'Status' property, 'Size' alias, and 'SizeInMB' method to the FileInfo object.
> $A = Get-ChildItem c:\ps-test\test.txt
> $A | Add-Member -NotePropertyName Status -NotePropertyValue InProgress
> $A.Status
InProgress

> $A | Add-Member -MemberType AliasProperty -Name Size -Value Length
> $A.Size
93681943

> $method = {[math]::Round(($this.Length / 1MB), 2)}
> $A | Add-Member -MemberType ScriptMethod -Name "SizeInMB" -Value $method
> $A.SizeInMB()
89.34

> $A.Status = 'Complete'
> $A.Status
Complete
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-member'
	'https://ilovepowershell.com/powershell-modern/ultimate-guide-to-using-powershell-add-member-cmdlet/'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
