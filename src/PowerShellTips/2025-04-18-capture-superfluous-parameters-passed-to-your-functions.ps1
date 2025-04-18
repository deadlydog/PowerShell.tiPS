$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-18')
$tip.Title = 'Capture superfluous parameters passed to your function(s)'
$tip.TipText = @'
Capture any parsed parameter to prevent a function from bombing out when being passed unknown / misspelled variables.
Comes in handy when parsing the $PSBoundParameters from a calling script with just a subset of parameters that are appropriate / needed by your (custom) function.
'@
$tip.Example = @'
[CmdletBinding()]
param(
[Parameter(DontShow, ValueFromRemainingArguments)]$Superfluous
)

Write-Verbose -Message "Ignoring superfluous params: $($Superfluous -join ' ')"
'@
$tip.Urls = @('https://github.com/ChristelVDH/SyncAD2AAD/blob/main/ConnectTo-Graph.ps1','https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.parameterattribute.valuefromremainingarguments','https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.parameterattribute.dontshow')
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Christel VdH' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
