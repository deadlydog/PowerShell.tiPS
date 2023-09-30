$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-22')
$tip.Title = 'Avoid Array addition'
$tip.TipText = @'
Array addition is an expensive and inefficient operation and can usually be replaced by PowerShell explicit loop assignment.

Use a `List<T>` instead in those cases when adding to a collection while looping is required.
'@
$tip.Example = @'
# Array addition:
$items = @()
foreach ($i in 0..10) {
    $items += $i
}

# Can be easily replaced with explicit assignment:
$items = foreach ($i in 0..10) {
    $i
}

# And, when not possible, a List<T> is recommended:
$items = [System.Collections.Generic.List[int]]::new()
foreach ($i in 0..10) {
    $items.Add($i)
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/dev-cross-plat/performance/script-authoring-considerations?view=powershell-7.3#array-addition'
)
$tip.Category = [tiPS.TipCategory]::Performance # Community, Editor, Module, NativeCmdlet, Performance, Syntax, Terminal, or Other.
