function Get-PowerShellTip
{
<#
	.SYNOPSIS
	Get a PowerShellTip object. If no parameters are specified, a random tip is returned.

	.DESCRIPTION
	Get a PowerShellTip object. If no parameters are specified, a random tip is returned.

	The list of tips already shown is stored in a file in the TiPS data directory.
	If no parameters are provided, a random tip is returned from the list of tips that have not yet been shown.
	When a tip is shown, it is added to the list.
	If all tips have been shown, the list is reset.

	.PARAMETER Id
	The ID of the tip to retrieve. If not supplied, a random tip will be returned.

	.PARAMETER AllTips
	Return all tips.

	When this parameter is used, the list of tips shown is not updated.

	.INPUTS
	You can pipe a [string] of the ID of the tip to retrieve, or a PSCustomObject with a [string] 'Id' property.

	.OUTPUTS
	A [tiPS.PowerShellTip] object representing the PowerShell tip.

	If the -AllTips switch is provided, a [System.Collections.Specialized.OrderedDictionary] is returned.

	.EXAMPLE
	Get-PowerShellTip

	Get a random tip that has not been shown yet.

	.EXAMPLE
	Get-PowerShellTip -Id '2023-07-16-powershell-is-open-source'

	Get the tip with the specified ID. If no tip with the specified ID exists, an error is written.

	.EXAMPLE
	Get-PowerShellTip -AllTips

	Get all tips.

	.EXAMPLE
	'2023-07-16-powershell-is-open-source' | Get-PowerShellTip

	Pipe a [string] of the ID of the tip to retrieve.

	.EXAMPLE
	[PSCustomObject]@{ Id = '2023-07-16-powershell-is-open-source' } | Get-PowerShellTip

	Pipe an object with a [string] 'Id' property of the tip to retrieve.
#>

	[CmdletBinding(DefaultParameterSetName = 'Default')]
	[OutputType([tiPS.PowerShellTip], ParameterSetName = 'Default')]
	[OutputType([System.Collections.Specialized.OrderedDictionary], ParameterSetName = 'AllTips')]
	Param
	(
		[Parameter(ParameterSetName = 'Default', Mandatory = $false,
			ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true,
			HelpMessage = 'The ID of the tip to retrieve. If not supplied, a random tip will be returned.')]
		[string] $Id,

		[Parameter(ParameterSetName = 'AllTips', Mandatory = $false, HelpMessage = 'Return all tips.')]
		[switch] $AllTips
	)

	Process
	{
		if ($AllTips)
		{
			return ReadAllPowerShellTipsFromJsonFile
		}

		[bool] $allTipsHaveBeenShown = $script:UnshownTips.Count -eq 0
		if ($allTipsHaveBeenShown)
		{
			ResetUnshownTips
		}

		[bool] $tipIdWasProvided = (-not [string]::IsNullOrWhiteSpace($Id))
		if ($tipIdWasProvided)
		{
			[bool] $unshownTipsDoesNotContainTipId = (-not $script:UnshownTips.ContainsKey($Id))
			if ($unshownTipsDoesNotContainTipId)
			{
				[hashtable] $allTips = ReadAllPowerShellTipsFromJsonFile
				[bool] $tipIdDoesNotExist = (-not $allTips.ContainsKey($Id))
				if ($tipIdDoesNotExist)
				{
					Write-Error "A tip with ID '$Id' does not exist."
					return
				}
				[tiPS.PowerShellTip] $tip = $allTips[$Id]
				return $tip
			}
		}
		else
		{
			Write-Verbose "A Tip ID was not provided, so getting an unshown tip based on the user's configuration."
			switch ($script:TiPSConfiguration.TipRetrievalOrder)
			{
				([tiPS.TipRetrievalOrder]::NewestFirst) { $Id = $script:UnshownTips.Keys[-1]; break }
				([tiPS.TipRetrievalOrder]::OldestFirst) { $Id = $script:UnshownTips.Keys[0]; break }
				([tiPS.TipRetrievalOrder]::Random) { $Id = $script:UnshownTips.Keys | Get-Random -Count 1; break }
			}
		}

		[tiPS.PowerShellTip] $tip = $script:UnshownTips[$Id]
		MarkTipIdAsShown -TipId $Id
		return $tip
	}
}

function ResetUnshownTips
{
	[CmdletBinding()]
	[OutputType([void])]
	Param()

	Write-Verbose "Resetting the list of unshown tips, and clearing the list of shown tips."
	$script:UnshownTips = ReadAllPowerShellTipsFromJsonFile
	ClearTipIdsAlreadyShown
}

function MarkTipIdAsShown
{
	[CmdletBinding()]
	[OutputType([void])]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The ID of the tip to mark as shown.')]
		[string] $TipId
	)

	$script:UnshownTips.Remove($TipId)
	if ($script:UnshownTips.Count -eq 0)
	{
		ResetUnshownTips
	}
	else
	{
		AppendTipIdToTipIdsAlreadyShown -TipId $TipId
	}
}
