🚧 This repository is new and still under construction. The PowerShell module is not ready for consumption yet. 🚧

<p align="center">
  <a href="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-and-test-powershell-module.yml"><img alt="Build status" src="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-and-test-powershell-module.yml/badge.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/deploy-powershell-module.yml"><img alt="Deploy status" src="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/deploy-powershell-module.yml/badge.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/blob/main/License.md"><img alt="License" src="https://img.shields.io/github/license/deadlydog/PowerShell.tiPS.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/blob/main/docs/Contributing.md"><img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/tiPS"><img alt="Stable PowerShell module version" src="https://img.shields.io/powershellgallery/v/tiPS.svg"></a>
  <a href="https://www.powershellgallery.com/packages/tiPS"><img alt="Prerelease PowerShell module version" src="https://img.shields.io/powershellgallery/vpre/tiPS.svg?include_prereleases&label=powershell%20gallery%20prerelease&colorB=yellow"></a>
  <a href="https://www.powershellgallery.com/packages/tiPS"><img src="https://img.shields.io/powershellgallery/dt/tiPS.svg"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/powershellgallery/p/tiPS.svg">
  <img src="https://img.shields.io/github/languages/top/deadlydog/PowerShell.tiPS.svg">
  <img src="https://img.shields.io/github/languages/code-size/deadlydog/PowerShell.tiPS.svg">
</p>

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
Create a copy of the [0000-00-00-tip-template.ps1](src/PowerShellTips/0000-00-00-tip-template.ps1) file in the [PowerShellTips directory](src/PowerShellTips), modify it with your tip info, and submit a pull request.

tiPS is open source, and contributions are not only welcome, they are encouraged! 😀

tiPS is meant to be a community driven project, so please help make it better by contributing your tips and tricks.

Issues and Pull Requests are welcome.
See [the Contributing page](docs/Contributing.md) for more details.

## 📃 Changelog

See what's changed in the module over time by viewing [the changelog](Changelog.md).

## 💳 Donate

Buy me a bagel for providing this module open source and for free 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JV6M4PKNLFQNQ)
