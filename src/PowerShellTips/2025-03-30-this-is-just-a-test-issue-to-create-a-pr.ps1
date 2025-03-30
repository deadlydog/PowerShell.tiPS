$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-03-30')
$tip.Title = 'This is just a test issue to create a PR'
$tip.TipText = @'
Did you know

you can 'create'

multiline tips! Yeah, cool, right! "Uh huh"

Even with ` backticks
'@
$tip.Example = @'
Here is some example code

Write-ExampleCode -Now

Alright, alright

# It supports comments too
In case you didn't know.
'@
$tip.Urls = @('')
$tip.Category = [tiPS.TipCategory]::Community # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = '' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
