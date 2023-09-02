function GetApplicationDataDirectoryPath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $usersLocalAppDataPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)
	[string] $appDataDirectoryPath = Join-Path -Path $usersLocalAppDataPath -ChildPath 'PowerShell' -AdditionalChildPath 'tiPS'
	return $appDataDirectoryPath
}
