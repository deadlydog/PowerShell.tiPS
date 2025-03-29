$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-29')
$tip.Title = 'Check out this `Amazing` feature!'
$tip.TipText = Did you know

That you can do things.

Like 'quotes' and 

"double quotes"

That's right!

Even `backtickets`!!!
$tip.Example = 
$tip.Urls = @('https://one.com','https://two.com')
$tip.Category = [tiPS.TipCategory]::Performance # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = '' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
