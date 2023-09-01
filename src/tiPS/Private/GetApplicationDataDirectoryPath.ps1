function GetApplicationDataDirectoryPath
{
	[OutputType([string])]
	[CmdletBinding()]
	Param()

	[string] $usersLocalAppDataPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)
	[string] $appDataDirectoryPath = Join-Path -Path $usersLocalAppDataPath -ChildPath 'PowerShell' -AdditionalChildPath 'tiPS'
	return $appDataDirectoryPath
}
