$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2025-04-04')
$tip.Title = 'Submit your own tiPS tips from the web form'
$tip.TipText = @'
You can now easily submit your own PowerShell tips for the tiPS module right from the GitHub repository website! There is a new GitHub issue template called "PowerShell tip submission". When you open an issue you will be prompted for your tip's information, such as the tip title, text, category, example code, and URLs. You can even enter your GitHub email address so that you are tagged as a co-author on the commit, allowing you to still get credit in the git history.

This tip was submitted using a GitHub issue. Visit the website and submit a tip today!
'@
$tip.Example = @'
Start-Process 'https://github.com/deadlydog/PowerShell.tiPS/issues/new?template=new_powershell_tip.yml'
'@
$tip.Urls = @('https://github.com/deadlydog/PowerShell.tiPS/issues/new?template=new_powershell_tip.yml','https://github.com/deadlydog/PowerShell.tiPS#-contribute-a-tip')
$tip.Category = [tiPS.TipCategory]::Module # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)' # Optional. Get credit for your tip. e.g. 'Daniel Schroeder (deadlydog)'.
#$tip.ExpiryDate = [DateTime]::Parse('2024-10-30') # Optional. If the tip is not relevant after a certain date, set the expiration date. e.g. Announcing a conference or event.

# Tip submitted via GitHub issue workflow.
