$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-22')
$tip.Title = 'Avoid Array addition'
$tip.TipText = @'
Array addition is a expensive and inefficient operation and can, most of the times, be replaced by PowerShell explicit loop assignment.

Use a `List<T>` instead in those cases when adding to a collection while looping is required.
'@
$tip.Example = @'
# Array addition:
$result = @()
foreach ($i in 0..10) {
    $result += $i
}

# Can be easily replaced with explicit assignemnt:
$result = foreach ($i in 0..10) {
    $i
}

# And, when not possible, a List<T> is recommended:
$result = [System.Collections.Generic.List[int]]::new()
foreach ($i in 0..10) {
    $result.Add($i)
}
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/scripting/dev-cross-plat/performance/script-authoring-considerations?view=powershell-7.3#array-addition'
)
$tip.MinPowerShellVersion = '5.1'
$tip.Category = [tiPS.TipCategory]::Other # Community, CoreCmdlet, Editor, Module, Syntax, Terminal, or Other.
