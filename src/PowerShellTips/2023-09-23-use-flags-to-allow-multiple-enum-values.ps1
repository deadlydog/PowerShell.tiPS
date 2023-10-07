$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-09-23')
$tip.Title = 'Use Flags to allow multiple enum values'
$tip.TipText = @'
You can use the [Flags()] attribute to allow multiple enum values to be used at once. In addition to the attribute, you need to set the enum values to powers of 2 (1, 2, 4, 8, 16, etc.). This allows you to use the bitwise operators to combine enum values.

When using a flags enum you must be careful to not use the -eq operator to check if a variable contains a specific enum value. This will only return true if the variable contains only that enum value. Instead, use the -band operator or the .HasFlag() method to check if the variable contains a specific enum value.
'@
$tip.Example = @'
[Flags()]
enum FileAttributes {
    Archive    = 1
    Compressed = 2
    Device     = 4
    Directory  = 8
    Encrypted  = 16
    Hidden     = 32
}

# Set a variable to multiple enum values.
$attributes = [FileAttributes]::Archive + [FileAttributes]::Hidden
$attributes += [FileAttributes]::Compressed

# Check if the variable contains a specific enum value.
$attributes -eq [FileAttributes]::Archive # False
$attributes -band [FileAttributes]::Archive # True
$attributes.HasFlag([FileAttributes]::Archive) # True
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_enum#enumerations-as-flags'
	'https://arcanecode.com/2021/12/06/fun-with-powershell-enum-flags/'
)
$tip.Category = [tiPS.TipCategory]::Syntax # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
