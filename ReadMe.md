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

`tiPS` is a cross-platform PowerShell module that provides PowerShell tips.
This includes learning about things like:

- PowerShell features
- PowerShell best practices
- PowerShell modules
- PowerShell communities and events

tiPS provides a low-effort way to learn new things about PowerShell, and help you become a better PowerShell user.

tiPS is a community driven project.
Have a tip, module, blog post, or community event that you think others may find valuable?
See the Contributing section below for how to add your tips to tiPS.

## ❓ Why this exists

There are tons of great tips and tricks for PowerShell scattered around on the internet, but they require you to actively go look for them.
This module brings tips to you with minimal effort required on your part.

You can configure tiPS to show a tip every time you open your PowerShell terminal, or simply show a tip on demand by running the `tips` command.

## 🚀 Quick start

Paste the following commands into your PowerShell terminal to install tiPS and have it automatically show you a new tip every day:

```powershell
Install-Module -Name tiPS -Scope CurrentUser
Add-TiPSImportToPowerShellProfile
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyUpdateModule Weekly
```

That's it! The above commands are explained in more detail below.

### 💿 Installation

The tiPS PowerShell module can be downloaded from [the PowerShell Gallery](https://www.powershellgallery.com/packages/tiPS) and installed by running the following command in PowerShell:

```powershell
Install-Module -Name tiPS -Scope CurrentUser
```

To show tips automatically, tiPS must be imported when the PowerShell session starts.
To have this happen automatically you can manually add `Import-Module -Name tiPS` to your PowerShell profile, or simply run the following command to do it for you:

```powershell
Add-TiPSImportToPowerShellProfile
```

> You can remove the import statement from your PowerShell profile by running the `Remove-TiPSImportFromPowerShellProfile` command.

### ⚙ Recommended configuration

The following configuration is a good balance for displaying new tips automatically and not being overwhelmed by them.

```powershell
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyUpdateModule Weekly
```

By default tiPS does not automatically show tips or update itself, so you must configure it to do so.

## Commands

To see the full list of commands, use `Get-Command -Module tiPS`.
You can then use `Get-Help <command>` to get more information about a specific command.
Below are the popular operations.

### 📰 Show a tip

To show a nicely formatted tip in the terminal use:

```powershell
Write-PowerShellTip
```

or its alias:

```powershell
tips
```

### 💁‍♂️ Get a tip

To get a tip as an object that can be saved in a variable or piped to other commands, use:

```powershell
Get-PowerShellTip
```

### 🤖 Automatic tip on PowerShell startup

To have a tip automatically displayed every time you open your PowerShell terminal, run:

```powershell
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip EverySession
```

Possible values for the `-AutomaticallyWritePowerShellTip` parameter are `Never`, `EverySession`, `Daily`, and `Weekly`.

Tips will only be automatically shown in interactive PowerShell sessions.
This prevents them from appearing unexpectedly when running scripts or other automated processes.

### ⬆ Automatic updates

New tips are obtained by updating the tiPS module.
Instead of remembering to manually update the module to see up-to-date tips, you can have the module automatically update itself by running:

```powershell
Set-TiPSConfiguration -AutomaticallyUpdateModule Weekly
```

Possible values for the `-AutomaticallyUpdateModule` parameter are `Never`, `Daily`, `Weekly`, `Biweekly`, and `Monthly`.

Automatic updates are performed in a background job, so they will not block your PowerShell session from starting.
The updated module will be loaded the next time you open a PowerShell terminal or import tiPS.
Old versions of the module are automatically deleted after a successful update.

### ❌ Uninstalling tiPS

If you imported tiPS into your PowerShell profile, the import statement will not be removed if you just uninstall the tiPS module.
If you uninstall the module without removing the import statement, you will get an error message every time you open a PowerShell terminal.

If you added the import statement to your PowerShell profile using the `Add-TiPSImportToPowerShellProfile`, you can remove it with:

```powershell
Remove-TiPSImportFromPowerShellProfile
```

If you manually added the import statement to your PowerShell profile, you will need to remove it manually.
To see if tiPS is being imported by your PowerShell profile, and by which file, run the command:

```powershell
Test-PowerShellProfileImportsTiPS -Verbose
```

### 📁 Get directory where user configuration is stored

To get the directory where the tiPS configuration and other related data is stored, run:

```powershell
Get-TiPSConfigurationDirectory
```

To restore tiPS to the default configuration, simply delete the directory.
If tiPS is uninstalled, the directory is not automatically deleted; it must be done manually.
The directory is very small though, so it is not a big deal if it is left behind.

## ➕ How to contribute

tiPS is open source, and contributions are not only welcome, they are encouraged! 😀

Have a PowerShell tip you want to share?
Know of a great module, blog post, or community event that you think others should know about?

Follow these steps to add your tip to tiPS:

1. Fork this repo to your account ([See GitHub docs](https://docs.github.com/en/get-started/quickstart/fork-a-repo)).
1. Clone the repo to your local machine, or open it in a GitHub Codespace, and create a new branch.
1. Run the [New-PowerShellTip script](/tools/New-PowerShellTip.ps1) to create your new tip file in the [PowerShellTips directory](/src/PowerShellTips/).
1. Modify it with your tip info and commit your changes.
1. Submit a pull request from your fork back to this repo ([See GitHub docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)).

tiPS is meant to be a community driven project, so please help make it better by contributing your tips.

Issues, Discussions, and Pull Requests are welcome.
See [the Contributing page](/docs/Contributing.md) for more details.

## 🛣 Roadmap

Below is a short list of planned enhancements for tiPS:

- Remember which tips have been shown to the user so that they are not shown again until all tips have been viewed.
- Ability to show tips in a specific order. e.g. Newest tips first.
- Ability to not show certain categories of tips. e.g. Do not show Community tips.
- An easier way to add new tips. e.g. a simple web form that can be filled out.
- A way to customize the look of the tip when it is displayed. e.g. add a border around it, change the colors, etc.

## 📃 Changelog

See what's changed in the module over time by viewing [the changelog](Changelog.md).

## 💳 Donate

Buy me a bagel for providing this module open source and for free 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JV6M4PKNLFQNQ)
