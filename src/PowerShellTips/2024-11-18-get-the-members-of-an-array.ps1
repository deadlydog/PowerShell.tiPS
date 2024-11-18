$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-11-18')
$tip.Title = 'Get the members of an array'
$tip.TipText = @'
PowerShell sends the items in an array one at a time when you pipe an array to Get-Member and it ignores duplicates
'@
$tip.Example = @'
# When you pipe to Get-Member PowerShell enumerates the array and you get the properties of the items inside the array, in this case a string
PS C:\> [array]$myArray = @('one','two','three')
PS C:\> $myArray | Get-Member

   TypeName: System.String

# This example will output the members of the array
PS C:\> Get-Member -InputObject $myArray

   TypeName: System.Object[]

# This will also do the same by making the array the second item in an array of arrays
,$myArray | Get-Member

# To see what type of object is in a variable use the GetType method.
PS C:\> $myArray.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Object[]                                 System.Array
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.4'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-7.4#get-the-members-of-an-array'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Adrian Muscat (adrimus)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

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
