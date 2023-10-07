$tip = [tiPS.PowerShellTip]::new()
$tip.CreatedDate = [DateTime]::Parse('2023-10-07')
$tip.Title = 'Store and retrieve secrets securely with SecretManagement'
$tip.TipText = @'
The Microsoft.PowerShell.SecretManagement module allows you to store secrets securely in a vault and retrieve them interactively, or in automated processes. This provides a secure alternative to storing secrets in plain text files, or continually being prompted for them.

The Microsoft.PowerShell.SecretStore module is a vault for storing secrets locally on your machine. There are other modules that provide integration with other vaults, such as Azure Key Vault, HashiCorp Vault, and LastPass. You can view them at https://aka.ms/SecretManagementVaults.
'@
$tip.Example = @'
# Install the SecretManagement and SecretStore modules.
Install-Module Microsoft.PowerShell.SecretManagement -Repository PSGallery
Install-Module Microsoft.PowerShell.SecretStore -Repository PSGallery

# Register the SecretStore vault with the SecretManagement module.
Register-SecretVault -Name LocalFileSecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

# Store a secret in the vault (will be prompted for a vault password the 1st time).
Set-Secret -Name MySecret -Secret 'MySecretValue'

# Retrieve the secret from the vault.
Get-Secret -Name MySecret
'@
$tip.Urls = @(
	'https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.secretmanagement/?view=ps-modules'
	'https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/'
	'https://www.pdq.com/blog/how-to-manage-powershell-secrets-with-secretsmanagement/'
)
$tip.Category = [tiPS.TipCategory]::Security # Community, Editor, Module, NativeCmdlet, Performance, Security, Syntax, Terminal, or Other.

# Community: Social events and community resources. e.g. PowerShell Summit, podcasts, etc.
# Editor: Editor tips and extensions. e.g. VSCode, ISE, etc.
# Module: Modules and module tips. e.g. PSScriptAnalyzer, Pester, etc.
# NativeCmdlet: Native cmdlet tips. e.g. Get-Process, Get-ChildItem, Get-Content, etc.
# Performance: Tips to improve runtime performance. e.g. foreach vs ForEach-Object, ForEach-Object -Parallel, etc.
# Security: Security tips. e.g. ExecutionPolicy, Constrained Language Mode, passwords, etc.
# Syntax: Syntax tips. e.g. splatting, pipeline, etc.
# Terminal: Terminal shortcuts and tips. e.g. PSReadLine, Windows Terminal, ConEmu, etc.
# Other: Tips that don't fit into any of the other categories.
