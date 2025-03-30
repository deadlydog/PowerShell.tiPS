$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-30')
$tip.Title = 'This is a test issue to see how well this works'
$tip.TipText = @'
Did you know about this thing?

It's called Some-Thing and uses `this other thing`.

It 'includes' a few "other things" too.

Don't wait to use it!
'@
$tip.Example = @'

'@
$tip.Urls = @('https://one.com','http://two.com')
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = '' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
