$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-30')
$tip.Title = 'Use `Do-Something -Cool` to do the thing!'
$tip.TipText = @'
Here is a cool tip for you!

Did you know about 'this' "thing" `called` _foo_?

Yeah, me neither `

Dumm dumm dumm
'@
$tip.Example = @'
You can Write-ExampleCode -Like this.

Oh, that's cool.

`You're` darn tootin it is!
'@
$tip.Urls = @('')
$tip.Category = [tiPS.TipCategory]::NativeCmdlet # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = '' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
