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

## Directory structure

The main components of the repository are organized as follows:

```text
Repository root
├───.devcontainer: VS Code development container configuration
├───.github: GitHub configuration
│   └───workflows: GitHub Actions workflows
├───.vscode: VS Code configuration
│       tasks.json: VS Code tasks for simulating building the module and running tests
├───build: Scripts and files used when building the module
├───deploy: Scripts and files used when deploying the module
├───docs: Documentation
├───src: Source code and tests
│   │   PowerShellTipsDirectory.Tests.ps1: Tests to validate the files in the PowerShellTips directory are valid
│   ├───PowerShellTips: The tips to be compiled into the JSON file that is published with the module
│   └───tiPS: Files that make up the PowerShell module
│       │   PowerShellTips.json: The tips published with the module
│       │   tiPS.psd1: The PowerShell module manifest
│       │   tiPS.psm1: The root PowerShell module script
│       ├───Classes: The classes of the module
│       ├───Private: The private functions of the module
│       └───Public: The public functions of the module
└───tools: Additional tools/scripts used during development
```

The Pester test files (*.Tests.ps1) are typically located in the same directory as the file being tested.
These files are not included in the published module.

## ⁉ Why was a specific decision made

Curious about some of the choices made in this project?
The reasons may be documented in the [Architecture Decision Records](docs/ArchitectureDecisionRecords).
