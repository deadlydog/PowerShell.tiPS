$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-10-01')
$tip.Title = 'Use PSDates to easily work with time zones'
$tip.TipText = @'
The PSDates module makes it easy to work with dates and times across different time zones. It contains functions to help you find and convert date formats, get certain dates based on other dates (first/last day of the month or year, patch Tuesday, etc). It includes functions for working with timezones, unix time, WMI time, crontab schedules, and more.
'@
$tip.Example = @'
# Convert the local system time to GMT Standard Time.
Convert-TimeZone -ToTimeZone "GMT Standard Time"

# Convert the date and time 11/17/2017 12:34 AM from 'China Standard Time' to 'US Mountain Standard Time'.
Convert-TimeZone -date '11/17/2017 12:34 AM' -FromTimeZone "China Standard Time" -ToTimeZone "US Mountain Standard Time"

# Get the datetime for the Unix time 1509512400.
ConvertFrom-UnixTime -UnixTime 1509512400

# Get the datetime for the Wmi time 20190912173652.000000-300.
ConvertFrom-WmiDateTime -WmiTime '20190912173652.000000-300'

# Explain the crontab expression '0 17 * * 1'. Output: At 05:00 PM, only on Monday
Get-CronDescription -Crontab '0 17 * * 1'

# Get the next occurrence of the crontab from the current time.
Get-CronNextOccurrence -Crontab '0 17 * * *'
'@
$tip.Urls = @(
	'https://github.com/mdowst/PSDates'
)
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
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
