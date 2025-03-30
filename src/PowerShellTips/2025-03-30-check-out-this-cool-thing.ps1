$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-30')
$tip.Title = 'Check out this cool thing'
$tip.TipText = @'
Did you know that
you can do things

Like-This!
'@
$tip.Example = @'
And-Use -Code like this

too!!
'@
$tip.Urls = @('https://moreinfohere.com','https://andheretoo.com','http://Andhere.com')
$tip.Category = [tiPS.TipCategory]::Performance # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
