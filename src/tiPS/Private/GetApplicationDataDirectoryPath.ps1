function GetApplicationDataDirectoryPath
{
	[CmdletBinding()]
	Param()

	[string] $dataDirectoryPath = [System.IO.Path]::Combine(
		[System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::LocalApplicationData),
		"PowerShell",
		"tiPS"
	)
	return $dataDirectoryPath
}
