# Contributing to this project

Feel free to open an issue or pull request.

## 🐛 Issues

If you open an issue, please:

- Indicate whether it is a bug or feature enhancement.
- For bugs, provide a detailed description, including:
  - any error messages and reproduction steps
  - log output or files
  - screenshots, gifs, or videos
  - example code

## Adding a tip

The instructions for adding a new tip to the module are located on the [ReadMe](/ReadMe.md).

## Module development

This PowerShell module is developed using Visual Studio Code.
If you encounter any issues developing on your local machine, you can use [Docker Desktop](https://www.docker.com/products/docker-desktop/) and the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VS Code extension to develop in a Docker container with all of the required dependencies, so that you do not have to install them locally.
You may also develop in your web browser with GitHub Codespaces to avoid needing to put any code or dependencies on your local machine.

Before spending too much time on a pull request, please open an issue or discussion to discuss the proposed change.

### Directory structure

The main components of the repository are organized as follows:

```graphql
Repository root
├───.devcontainer # VS Code development container configuration
├───.github # GitHub configuration
│   └───workflows # GitHub Actions workflows
├───.vscode # VS Code configuration
│       tasks.json # VS Code tasks for simulating building the module and running tests
├───build # Scripts and files used when building the module
├───deploy # Scripts and files used when deploying the module
├───docs # Documentation
├───src # Source code and tests
│   │   PowerShellTipsDirectory.Tests.ps1 # Tests to validate the files in the PowerShellTips directory are valid
│   ├───PowerShellTips # The tips to be compiled into the JSON file that is published with the module
│   └───tiPS # Files that make up the PowerShell module
│       │   PowerShellTips.json # The tips published with the module
│       │   tiPS.psd1 # The PowerShell module manifest
│       │   tiPS.psm1 # The root PowerShell module script
│       ├───Classes # The classes of the module
│       ├───Private # The private functions of the module
│       └───Public # The public functions of the module
└───tools # Additional tools/scripts used during development
```

The Pester test files (*.Tests.ps1) are typically located in the same directory as the file being tested.
These files are not included in the published module.

### Building and testing

The code is built and tested by GitHub Actions on every commit to the `main` branch and every PR opened against the `main` branch.

When developing locally, you can use [the VS Code tasks](/.vscode/tasks.json) to simulate the build and test process and be notified of any problems before pushing your code up to GitHub.
In VS Code, open the command palette (Ctrl+Shift+P) and select `Tasks: Run Build Task` or `Tasks: Run Test Task`.

After building, you can use [the TestLocalModule.ps1 script](/tools/TestLocalModule.ps1) to test your local changes and see what the final end-user experience looks like.

The build process performs the following operations:

1. Use dotnet.exe to build the C# assemblies and copy them to the PowerShell module's directory
   1. [This ADR](/docs/ArchitectureDecisionRecords/006-Where-to-define-classes.md) explains why we use a C# assembly for the strongly-typed classes.
1. (VS Code build only) Ensure all of the PowerShellTips filenames match their Tip ID, and rename them if they do not.
1. Generate the PowerShellTips.json file from the files in the PowerShellTips directory.
   1. [This ADR](/docs/ArchitectureDecisionRecords/004-Save-all-tips-to-a-single-file.md) explains why we save all of the tips to a single file.
1. Run the PSScriptAnalyzer linter on all of the PowerShell files.
1. (Pipeline build only) Concatenate all of the PowerShell file contents into the psm1 file, and delete the ps1 files.
   1. [This ADR](/docs/ArchitectureDecisionRecords/005-How-to-dot-source-files-into-the-module-psm1-file.md) explains why we concatenate the files into the psm1 file.

The testing process performs the following operations:

1. Run Pester against all of the files that end in `.Tests.ps1` in the entire repo.
1. (Pipeline deploy only) After the module is deployed to the PowerShell Gallery, the module is downloaded from the PowerShell Gallery and the [Invoke-SmokeTests.ps1](/deploy/Invoke-SmokeTests.ps1) script is run against it on Windows PowerShell, and PowerShell Core on Windows, MacOS, and Ubuntu to validate the module is working as expected on all platforms.

### ⁉ Why was a specific decision made

Curious about some of the choices made in this project?
The reasons may be documented in the [Architecture Decision Records](/docs/ArchitectureDecisionRecords/).
