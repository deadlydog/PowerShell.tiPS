$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-17')
$tip.Title = 'Extend types with your own properties and methods'
$tip.TipText = @'
The `Update-TypeData` cmdlet can be used to add custom properties and methods to a type. This is useful when you want to extend the functionality of a type that you did not define, such as a built-in .NET class.

The `Update-TypeData` cmdlet has a `-MemberType` parameter that can be used to specify the type of member to add. The most common types are `NoteProperty` and `ScriptMethod`. The `NoteProperty` type is used to add a new property to an object, while the `ScriptMethod` type is used to add a method to an object to perform some action.

This is similar to using the `Add-Member` cmdlet, but `Update-TypeData` modifies the type data for all instances of the type, while `Add-Member` modifies only the instance you used it on.
'@
$tip.Example = @'
# Define the new function logic that we want add to the type.
[scriptblock] $GetValueOrDefaultFunction = {
    param($key, $defaultValue)
    if ($this.ContainsKey($key)) {
        $this[$key]
    } else {
        $defaultValue
    }
}

# Define that we want to add the new method to the Hashtable type, and call it GetValueOrDefault.
$extendedTypeData = @{
    TypeName = 'System.Collections.Hashtable'
    MemberType = 'ScriptMethod'
    MemberName = 'GetValueOrDefault'
    Value = $GetValueOrDefaultFunction
}

# Add the new method to the Hashtable type, via splatting.
Update-TypeData @extendedTypeData

# Now we can use the new method on any Hashtable object.
[hashtable] $myHashTable = @{ 'key1' = 'value1' }
$myHashTable.GetValueOrDefault('key1', 'unknown') # Returns 'value1'.
$myHashTable.GetValueOrDefault('key2', 'unknown') # Returns 'unknown'.
$myHashTable['key2'] # Returns $null.
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/update-typedata'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_classes_properties#defining-instance-properties-with-update-typedata'
	'https://x.com/blackboxcoder/status/1716585384102985949?t=-Ox1iPV67-4Vqb8wIZ275A'
)
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
