# Changelog

This page is a list of _notable_ changes made in each version.
Every time a tip is added the patch version is incremented, so there will be a lot of patch version changes not documented here.

## v0.5.0 - September 26, 2023

Features:

- Remember which tips have been shown and don't show them again until all tips have been shown.

## v0.4.0 - September 23, 2023

Features:

- Added new `Performance` category for tips.

Breaking Changes:

- Renamed the `CoreCmdlet` category to `NativeCmdlet`.

## v0.3.4 - September 19, 2023

Fixes:

- Handle passing an invalid Tip ID to `Write-PowerShellTip` more gracefully and display user-friendly error.

## v0.3.0 - September 17, 2023

Features:

- Update `Remove-TiPSImportFromPowerShellProfile` to match against additional `Import-Module -Name tiPS` patterns.

## v0.2.0 - September 16, 2023

Features:

- Added new `CoreCmdlet` category for tips.

## v0.1.1 - September 15, 2023

Features:

- Added `Remove-TiPSImportFromPowerShellProfile` function.

Breaking Changes:

- Rename `Edit-PowerShellProfileToImportTiPS` to `Add-TiPSImportToPowerShellProfile`

## v0.1.0 - September 15, 2023

- Initial beta release
