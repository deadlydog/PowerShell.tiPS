$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2024-10-13')
$tip.Title = 'Use Type Accelerators instead of fully qualified class names'
$tip.TipText = @'
Type accelerators allow us to use a short alias for a .NET type, instead of typing the fully qualified class name. There are many built-in type accelerators, such as:

[int] instead of [System.Int32]
[string] instead of [System.String]
[datetime] instead of [System.DateTime]
[array] instead of [System.Array]
[xml] instead of [System.Xml.XmlDocument]
[regex] instead of [System.Text.RegularExpressions.Regex]
[pscredential] instead of [System.Management.Automation.PSCredential]
[pscustomobject] instead of [System.Management.Automation.PSCustomObject]

See the About_Type_Accelerators help topic for a full list of built-in type accelerators.

We can also create type accelerators for our own custom types, or existing .NET types that do not have a type accelerator.
'@
$tip.Example = @'
# These lines are equivalent:
[int] $myNumber = 42
[System.Int32] $myNumber = 42

# These lines are equivalent:
[string]::IsNullOrWhiteSpace($someString)
[System.String]::IsNullOrWhiteSpace($someString)

# Create a type accelerator for an existing .NET class, and then use it to create a new instance.
$TypeAcceleratorsClass = [PSObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')
$TypeAcceleratorsClass::Add('TCP','System.Net.Sockets.TCPClient')
$tcpClient = [TCP]::new('localhost', 80)

# Show all available type accelerators.
[PSObject].Assembly.GetType('System.Management.Automation.TypeAccelerators')::Get
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_type_accelerators'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes#exporting-classes-with-type-accelerators'
	'https://4sysops.com/archives/using-powershell-type-accelerators/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
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
