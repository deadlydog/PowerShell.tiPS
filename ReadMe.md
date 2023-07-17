# tiPS PowerShell Module

PowerShell tips delivered straight to your terminal 💻.

## 💬 Description

`tiPS` is a PowerShell module that provides tips and tricks for using PowerShell.
It is meant to be a low effort way to learn new things about PowerShell, and to help you become a better PowerShell user.

## ❓ Why this exists

There are tons of great tips and tricks for PowerShell scattered around on the internet, but they require you to actively go look for them.
This module brings tips to you with minimal effort required on your part.

You can configure tiPS to show a tip every time you open your PowerShell terminal, or you can show a tip on demand by running the `tips` command.

## 🚀 Quick start

### 💿 Installation

The tiPS PowerShell module can be downloaded and installed by running the following command in PowerShell:

```powershell
Install-Module -Name tiPS -Scope CurrentUser
```

### 🤖 Automatic tip on PowerShell startup

To have a tip automatically displayed every time you open your PowerShell terminal, run the following command:

```powershell
Set-ShowPowerShellTipOnStartup
```

The above command will add a line to your PowerShell profile that will run the `tips` command every time you open your PowerShell terminal.

You can disable this behavior by running the following command:

```powershell
Set-ShowPowerShellTipOnStartup -Disable
```

## Usage

### Show a tip

To show a tip, run the following command:

```powershell
Write-PowerShellTip
```

This cmdlet can also be run using one of its aliases: `Write-PSTip`, `Write-Tip`, or `tips`.

If you know the ID of the tip you want to show, you can use the `-Id` parameter to show that specific tip.

```powershell
Write-PowerShellTip -Id 1
```

### Get a tip

To get a tip as an object, run the following command:

```powershell
Get-PowerShellTip
```

## ➕ How to contribute

Have a PowerShell tip you want to share?
Create a copy of the [_tip-template.ps1](src/Tips/_tip-template.ps1) file in the [Tips directory](src/Tips), modify it with your tip info, and submit a pull request.

tiPS is open source, and contributions are not only welcome, they are encouraged! 😀

tiPS is meant to be a community driven project, so please help make it better by contributing your tips and tricks.

Issues and Pull Requests are welcome.
See [the Contributing page](docs/Contributing.md) for more details.

## 📃 Changelog

See what's changed in the module over time by viewing [the changelog](docs/Changelog.md).

## ⁉ Why was a specific decision made

Curious about some of the choices made in this project?
Check out the [Architecture Decision Records](docs/ArchitectureDecisionRecords) to see why certain decisions were made.

## 💳 Donate

Buy me a bagel for providing this module open source and for free 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JV6M4PKNLFQNQ)
