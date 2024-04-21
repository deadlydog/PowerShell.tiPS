$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-08')
$tip.Title = 'Prompt users for credentials and secrets securely'
$tip.TipText = @'
Sometimes we write scripts that prompt the user for their credentials, or for a secret like a password. We should avoid retrieving these values in plain text.

To securely prompt a user for their credentials use the Get-Credential cmdlet. This will prompt the user for their username and password, and return a PSCredential object with the password stored as a SecureString.

The securely prompt a user for a secret, use the Read-Host cmdlet with the -AsSecureString parameter. This will prompt the user for a secret and return a SecureString.

Most cmdlets that require sensitive info will accept PSCredential or SecureString objects. In the rare case that you need the secret as plain text, you can convert the SecureString to plain text. This should be avoided if possible, as it exposes the secret in memory.
'@
$tip.Example = @'
# Prompt user for their username and password. The password will be stored as a SecureString.
[PSCredential] $userCredentials = Get-Credential -Message 'Enter your credentials'

# Some webhooks contain secrets, so treat them as sensitive.
[SecureString] $secureWebhook = Read-Host -Prompt 'Enter the webhook URL' -AsSecureString

# Convert a SecureString to plain text. AVOID THIS WHEN POSSIBLE.
[string] $plainTextWebhook = [System.Net.NetworkCredential]::new('', $secureWebhook).Password
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-credential'
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host'
	'https://www.pdq.com/blog/secure-password-with-powershell-encrypting-credentials-part-1/'
)
$tip.Category = [tiPS.TipCategory]::Security # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.
$tip.Author = 'Daniel Schroeder (deadlydog)'

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
