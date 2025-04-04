$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-04')
$tip.Title = 'Test title'
$tip.TipText = @'
Test description. Again. More. Again. More. Again.
'@
$tip.Example = @'

'@
$tip.Urls = @('')
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = '' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
