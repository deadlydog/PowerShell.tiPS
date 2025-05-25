<p align="center">
  <a href="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-and-test-powershell-module.yml"><img alt="Build status" src="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-and-test-powershell-module.yml/badge.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-test-and-deploy-powershell-module.yml"><img alt="Deploy status" src="https://github.com/deadlydog/PowerShell.tiPS/actions/workflows/build-test-and-deploy-powershell-module.yml/badge.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/blob/main/License.md"><img alt="License" src="https://img.shields.io/github/license/deadlydog/PowerShell.tiPS.svg"></a>
  <a href="https://github.com/deadlydog/PowerShell.tiPS/blob/main/docs/Contributing.md"><img alt="PRs welcome" src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/tiPS"><img alt="Stable PowerShell module version" src="https://img.shields.io/powershellgallery/v/tiPS.svg"></a>
  <a href="https://www.powershellgallery.com/packages/tiPS"><img alt="Prerelease PowerShell module version" src="https://img.shields.io/powershellgallery/vpre/tiPS.svg?include_prereleases&label=powershell%20gallery%20prerelease&colorB=yellow"></a>
  <a href="https://www.powershellgallery.com/packages/tiPS"><img src="https://img.shields.io/powershellgallery/dt/tiPS.svg"></a>
</p>

<p align="center">
  <!-- Must add 'Windows', 'MacOS', and 'Linux' to the module manifest tags for them to show up on the Platforms badge. -->
  <img src="https://img.shields.io/powershellgallery/p/tiPS.svg">
  <img src="https://img.shields.io/github/languages/top/deadlydog/PowerShell.tiPS.svg">
  <img src="https://img.shields.io/github/languages/code-size/deadlydog/PowerShell.tiPS.svg">
</p>

# tiPS PowerShell Module

PowerShell tips delivered straight to your terminal 💻.

## 💬 Description

`tiPS` is a cross-platform PowerShell module that provides PowerShell tips for things like:

- PowerShell features and best practices
- Helpful and cool PowerShell modules
- Terminal keyboard shortcuts
- Editor extensions to help with PowerShell development
- PowerShell communities and events

tiPS provides a low-effort way to learn new things about PowerShell, and help you become a better PowerShell user.

tiPS is community driven.
Have a tip, module, blog post, or community event that you think others may find valuable?
See [the Contributing section below](#-contribute-a-tip) for how to easily add your own tips to tiPS.

If you enjoy this module, consider giving it a GitHub star ⭐ to show your support.

## ❓ Why this exists

There are tons of great tips and tricks for PowerShell scattered around on the internet, but they require you to actively go look for them.
This module brings tips to you with minimal effort required on your part.

You can configure tiPS to show a tip every time you open your PowerShell terminal, or show a tip on demand by running the `tips` command.

## 🖼️ Screenshots

Calling the `tips` command to show a tip in the terminal:

![Using the tips command to show a tip](/docs/Images/using-tips-command-to-show-a-tip.png)

tiPS automatically showing a tip when PowerShell is opened:

![tiPS showing a tip automatically](/docs/Images/tips-showing-a-tip-automatically.png)

## 🚀 Quick start

Paste the following commands into your PowerShell terminal to install tiPS and have it automatically show you a new tip every day:

```powershell
Install-Module -Name tiPS -Scope CurrentUser
Add-TiPSImportToPowerShellProfile
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyUpdateModule Weekly
```

That's it!
Use the `tips` command to show a tip in the terminal, or just wait for tiPS to automatically show you a new tip every day.

The above commands are explained in more detail below.

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

### ⚙️ Recommended configuration

The following configuration is a good balance for displaying new tips automatically and not being overwhelmed by them.

```powershell
Set-TiPSConfiguration -AutomaticallyWritePowerShellTip Daily -AutomaticallyUpdateModule Weekly
```

By default tiPS does not automatically show tips or update itself, so you must configure it to do so by running the above command.

## 🔧 Commands

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

### ⬆️ Automatic updates

New tips are obtained by updating the tiPS module.
Instead of remembering to manually update the module, you can have the module automatically update itself by running:

```powershell
Set-TiPSConfiguration -AutomaticallyUpdateModule Weekly
```

Possible values for the `-AutomaticallyUpdateModule` parameter are `Never`, `Daily`, `Weekly`, `Biweekly`, and `Monthly`.

Automatic updates are performed in a background job, so they will not block your PowerShell session from starting.
The updated module will be loaded the next time you open a PowerShell terminal or import tiPS.
Old versions of the module are automatically deleted after a successful update.

### ❌ Uninstalling tiPS

If you imported tiPS into your PowerShell profile, the import statement will not be removed if you just uninstall the tiPS module.
If you uninstall the module without removing the import statement, you will get an error message every time you open a PowerShell terminal saying that it cannot find the tiPS module.

If you added the import statement to your PowerShell profile using the `Add-TiPSImportToPowerShellProfile`, you can remove it with:

```powershell
Remove-TiPSImportFromPowerShellProfile
```

If you manually added the import statement to your PowerShell profile, you may need to remove it manually.
To see which PowerShell profile file and line is importing tiPS, if any, run the command:

```powershell
Test-PowerShellProfileImportsTiPS -Verbose
```

NOTE: This only looks for the import statement directly in your PowerShell profile files, not any other files that are dot-sourced from your profile.

### 📁 Get directory where user configuration is stored

To get the directory where the tiPS configuration and other related data is stored, run:

```powershell
Get-TiPSDataDirectoryPath
```

To restore tiPS to the default configuration, simply delete the directory.
If tiPS is uninstalled, the directory is not automatically deleted; it must be done manually.
The directory is very small though, so it is not a big deal if it is left behind.

## ➕ Contribute a tip

tiPS is open source, and contributions are not only welcome, they are encouraged! 😀

Have a PowerShell tip you want to share?
Know of a great module, blog post, or community event that you think others should know about?

There are 2 ways to submit your tip to tiPS:

1. Use [the GitHub issue template](https://github.com/deadlydog/PowerShell.tiPS/issues/new?template=new_powershell_tip.yml) to create a PR for your new tip.
   This is the easiest way to submit a tip.
1. Fork the repo and create a PR for your tip the traditional way.
   You will need to fork the repo if you want to contribute other changes to the module, besides just new tips.

   Follow the steps below to fork the repo and manually submit your PR:
   1. Fork this repo to your account ([See GitHub docs](https://docs.github.com/en/get-started/quickstart/fork-a-repo)).
   1. Clone the repo to your local machine, or open it in GitHub Codespaces, and create a new branch.
   1. Run the [New-PowerShellTip script](/tools/New-PowerShellTip.ps1) to create your new tip file in the [PowerShellTips directory](/src/PowerShellTips/).
   1. Modify it with your tip info and commit your changes.
   1. Submit a pull request from your fork back to this repo ([See GitHub docs](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork)).

   🎦 [This video](https://youtu.be/OBg1KJf8sC4?si=CXEtMmaaZ3ybQAVF) walks through the above steps, showing how to fork the repo to contribute a new tip 🎦

tiPS is meant to be a community driven project, so please help make it better by contributing your tips.

Issues, Discussions, and Pull Requests are welcome.
See [the Contributing page](/docs/Contributing.md) for more details.

## 👥 Contributors

Thanks to these wonderful people who have contributed to tiPS:

<p align="center">
  <a href="https://github.com/deadlydog" title="deadlydog"><img src="https://avatars.githubusercontent.com/u/1187140?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="deadlydog"></a>
  <a href="https://github.com/apps/copilot-swe-agent" title="Copilot"><img src="https://avatars.githubusercontent.com/in/1143301?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="Copilot"></a>
  <a href="https://github.com/belibug" title="belibug"><img src="https://avatars.githubusercontent.com/u/61643561?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="belibug"></a>
  <a href="https://github.com/ruudmens" title="ruudmens"><img src="https://avatars.githubusercontent.com/u/20253186?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="ruudmens"></a>
  <a href="https://github.com/santisq" title="santisq"><img src="https://avatars.githubusercontent.com/u/23342410?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="santisq"></a>
  <a href="https://github.com/adrimus" title="adrimus"><img src="https://avatars.githubusercontent.com/u/37830358?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="adrimus"></a>
  <a href="https://github.com/ehmiiz" title="ehmiiz"><img src="https://avatars.githubusercontent.com/u/43292173?v=4" width="50" height="50" style="border-radius:50%;margin:5px;" alt="ehmiiz"></a>
</p>



## 🛣️ Roadmap

Below is a short list of planned enhancements for tiPS:

- A way to customize the look of the tip when it is displayed. e.g. add a border around it, change the colors, etc.
- Add a `Write-PowerShellTip -Previous` switch to output the last shown tip.

Have other ideas?
[Create a feature request issue](https://github.com/deadlydog/PowerShell.tiPS/issues/new/choose)

## 📃 Changelog

See what's changed in the module over time by viewing [the changelog](Changelog.md).

## ❤️ Donate to support this project

Buy me a bagel for providing this module open source and for free 🙂

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=JV6M4PKNLFQNQ)
