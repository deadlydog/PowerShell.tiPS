function GetApplicationDataDirectoryPath
{
	[CmdletBinding()]
	[OutputType([string])]
	Param()

	[string] $usersLocalAppDataPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData)
	[string] $appDataDirectoryPath =
		Join-Path -Path $usersLocalAppDataPath -ChildPath (
		Join-Path -Path 'PowerShell' -ChildPath 'tiPS')
	return $appDataDirectoryPath
}
