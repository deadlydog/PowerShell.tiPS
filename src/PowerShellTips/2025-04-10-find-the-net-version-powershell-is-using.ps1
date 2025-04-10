$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-10')
$tip.Title = 'Find the .NET version PowerShell is using'
$tip.TipText = @'
$PSVersionTable will tell you which version of PowerShell is running, but it won't tell you which version of .NET is being used. This is important as sometimes you want to call .NET methods from PowerShell, or use .NET types, but they may have changed from one .NET version to the next.

Minor Pwsh versions currently map to major .NET versions. For example, Pwsh 7.0 maps to .NET Core 3.1, 7.1 maps to .NET 5, 7.2 to .NET 6, 7.3 to .NET 7, 7.4 to .NET 8, and 7.5 to .NET 9. This isn't necessarily easy to remember though, and it may change in the future.

Rather than relying on remembering a convention, we can use the following command to display the version of .NET being used:
[System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription

Note: This property exists for all .NET Core versions, but was not introduced in .NET Framework until .NET Framework 4.7.1, so it may not work in Windows PowerShell versions using a lower version of .NET Framework.
'@
$tip.Example = @'
# Display the .NET version the current PowerShell session is using.
[System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/dotnet/api/system.runtime.interopservices.runtimeinformation.frameworkdescription'
)
$tip.Category = [tiPS.TipCategory]::Other # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Category meanings:
# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VS Code, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, keywords, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
