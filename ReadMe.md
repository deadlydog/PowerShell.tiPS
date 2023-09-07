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

In order for tiPS to show tips and update automatically, it must be imported every time you open a new PowerShell terminal.
To have this happen automatically you can manually add `Import-Module -Name tiPS` to your PowerShell profile, or simply run the following command to do it for you:

```powershell
Edit-PowerShellProfileToImportTiPS
```

### ⚙ Recommended configuration

The following configuration is a good balance between getting new tips and not being overwhelmed by them.

```powershell
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyUpdateModule Weekly
```

## Commands

### 📰 Show a tip

To show a tip, run the following command:

```powershell
Write-PowerShellTip
```

or use its alias:

```powershell
tips
```

### Get a tip

To get a tip as an object, run the following command:

```powershell
Get-PowerShellTip
```

### 🤖 Automatic tip on PowerShell startup

To have a tip automatically displayed every time you open your PowerShell terminal, run the following command:

```powershell
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip EverySession
```

Possible values for the `-AutomaticallyWritePowerShellTip` parameter are `Never`, `EverySession`, `Daily`, and `Weekly`.

### ⬆ Automatic updates

New tips are obtained by updating the tiPS module.
Rather than having to remember to manually update the module to see up-to-date tips, you can have the module automatically update itself by running the following command:

```powershell
Set-TiPSConfiguration -AutomaticallyUpdateModule Weekly
```

Possible values for the `-AutomaticallyUpdateModule` parameter are `Never`, `Daily`, `Weekly`, `Biweekly`, and `Monthly`.

## ➕ How to contribute

tiPS is open source, and contributions are not only welcome, they are encouraged! 😀

Have a PowerShell tip you want to share?
Know of a great module or community event that you think others should know about?

Follow these steps to add your tip to tiPS:

1. Fork this repo to your account.
1. Clone the repo to your local machine, or open it in a GitHub Codespace, and create a new branch.
1. Run the [New-PowerShellTip script](/tools/New-PowerShellTip.ps1) to create your new tip file in the [PowerShellTips directory](/src/PowerShellTips/).
1. Modify it with your tip info and commit your changes.
1. Submit a pull request from your fork back to this repo ([See GitHub docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)).

tiPS is meant to be a community driven project, so please help make it better by contributing your tips and tricks.

Issues and Pull Requests are welcome.
See [the Contributing page](/docs/Contributing.md) for more details.

## 📃 Changelog

See what's changed in the module over time by viewing [the changelog](Changelog.md).

## 💳 Donate

Buy me a bagel for providing this module open source and for free 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JV6M4PKNLFQNQ)
