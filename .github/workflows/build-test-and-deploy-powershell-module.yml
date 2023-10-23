name: deploy

on:
  push:
    branches: main
    paths: [ "src/**", "build/**", "deploy/**", ".github/workflows/**" ]

  # Allows you to run this workflow manually from the Actions tab.
  workflow_dispatch:
    inputs:
      versionNumber:
        description: 'The version number to use for the module. This should be in the format of "Major.Minor.Patch". e.g. "1.0.0". Future builds will increment from this version number. This input is optional. If not provided, the previous version numbers Patch will be incremented.'
        required: false
        type: string
        default: ''

env:
  artifactsDirectoryPath: './artifacts'

jobs:
  run-build-and-test:
    uses: ./.github/workflows/build-and-test-powershell-module.yml
    with:
      versionNumber: ${{ github.event.inputs.versionNumber }}

  publish-prerelease-module:
    needs: run-build-and-test
    runs-on: ubuntu-latest
    outputs:
      prereleaseVersionNumber: ${{ steps.output-version-number.outputs.prereleaseVersionNumber }}
    steps:
      - name: Download prerelease module artifact
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.prereleaseModuleArtifactName }}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Publish prerelease PowerShell module
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $moduleDirectoryPath = "$Env:artifactsDirectoryPath/$moduleName"
          Publish-Module -Path $moduleDirectoryPath -NuGetApiKey '${{ secrets.POWERSHELL_GALLERY_API_KEY }}' -Verbose

      - name: Make prerelease version number available to downstream jobs
        id: output-version-number
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $moduleManifestPath = "$Env:artifactsDirectoryPath/$moduleName/$moduleName.psd1"
          Write-Output "Reading module manifest from '$moduleManifestPath'."
          [hashtable] $manifest = Get-Content -Path $moduleManifestPath -Raw | Invoke-Expression
          [string] $versionNumber = $manifest.ModuleVersion
          [string] $prereleasePostfix = $manifest.PrivateData.PSData.Prerelease
          [string] $prereleaseVersionNumber = "$versionNumber-$prereleasePostfix"

          Write-Output "Saving the prerelease version number '$prereleaseVersionNumber' to an output variable."
          "prereleaseVersionNumber=$prereleaseVersionNumber" | Out-File -FilePath $Env:GITHUB_OUTPUT -Encoding utf8 -Append

      - name: Wait a short while for the module to be available on the PowerShell Gallery before continuing
        shell: pwsh
        run: Start-Sleep -Seconds 30

  test-prerelease-module-in-pwsh:
    needs: [run-build-and-test, publish-prerelease-module]
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macOS-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - name: Display PowerShell version being used
        shell: pwsh
        run: $PSVersionTable

      - name: Install prerelease module from PowerShell Gallery
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $prereleaseVersionNumber = '${{ needs.publish-prerelease-module.outputs.prereleaseVersionNumber }}'

          Write-Output "Installing the module '$moduleName' prerelease version '$prereleaseVersionNumber' from the PowerShell Gallery."
          Install-Module -Name $moduleName -AllowPrerelease -RequiredVersion $prereleaseVersionNumber -Force -Scope CurrentUser -Repository PSGallery -ErrorAction Stop -Verbose

      - name: Download deploy files artifact
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.deployFilesArtifactName}}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Run smoke tests
        shell: pwsh
        run: |
          [string] $smokeTestsScriptPath = "$Env:artifactsDirectoryPath/Invoke-SmokeTests.ps1"

          Write-Output "Running Pester smoke tests from file '$smokeTestsScriptPath'."
          $pesterConfig = New-PesterConfiguration @{
            Output = @{ Verbosity = 'Detailed' }
            Run = @{
              Path = $smokeTestsScriptPath
              Throw = $true
            }
          }
          Invoke-Pester -Configuration $pesterConfig

          Write-Output "Displaying the installed module version that was used for the smoke tests."
          Get-Module -Name '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'

  test-prerelease-module-in-windows-powershell:
    needs: [run-build-and-test, publish-prerelease-module]
    runs-on: windows-latest
    steps:
      - name: Display PowerShell version being used
        shell: powershell
        run: $PSVersionTable

      - name: Install prerelease module from PowerShell Gallery
        shell: powershell
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $prereleaseVersionNumber = '${{ needs.publish-prerelease-module.outputs.prereleaseVersionNumber }}'

          Write-Output "Installing the module '$moduleName' prerelease version '$prereleaseVersionNumber' from the PowerShell Gallery."
          Install-Module -Name $moduleName -AllowPrerelease -RequiredVersion $prereleaseVersionNumber -Force -Scope CurrentUser -Repository PSGallery -ErrorAction Stop -Verbose

      - name: Download deploy files artifact from triggered workflow
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.deployFilesArtifactName}}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Run smoke tests
        shell: powershell
        run: |
          [string] $smokeTestsScriptPath = "$Env:artifactsDirectoryPath/Invoke-SmokeTests.ps1"

          Write-Output "Running Pester smoke tests from file '$smokeTestsScriptPath'."
          $pesterConfig = New-PesterConfiguration @{
            Output = @{ Verbosity = 'Detailed' }
            Run = @{
              Path = $smokeTestsScriptPath
              Throw = $true
            }
          }
          Invoke-Pester -Configuration $pesterConfig

          Write-Output "Displaying the installed module version that was used for the smoke tests."
          Get-Module -Name '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'

  publish-stable-module:
    needs: [run-build-and-test, test-prerelease-module-in-pwsh, test-prerelease-module-in-windows-powershell]
    runs-on: ubuntu-latest
    environment: production # Used for deployment approvals.
    outputs:
      stableVersionNumber: ${{ steps.output-version-number.outputs.StableVersionNumber }}
    steps:
      - name: Download stable module artifact from triggered workflow
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.stableModuleArtifactName}}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Publish stable PowerShell module
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $moduleDirectoryPath = "$Env:artifactsDirectoryPath/$moduleName"
          Publish-Module -Path $moduleDirectoryPath -NuGetApiKey '${{ secrets.POWERSHELL_GALLERY_API_KEY }}' -Verbose

      - name: Make stable version number available to downstream jobs
        id: output-version-number
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $moduleManifestPath = "$Env:artifactsDirectoryPath/$moduleName/$moduleName.psd1"
          Write-Output "Reading module manifest from '$moduleManifestPath'."
          [hashtable] $manifest = Get-Content -Path $moduleManifestPath -Raw | Invoke-Expression
          [string] $versionNumber = $manifest.ModuleVersion

          Write-Output "Saving the stable version number '$versionNumber' to an output variable."
          "stableVersionNumber=$versionNumber" | Out-File -FilePath $Env:GITHUB_OUTPUT -Encoding utf8 -Append

      - name: Wait a short while for the module to be available on the PowerShell Gallery before continuing
        shell: pwsh
        run: Start-Sleep -Seconds 30

  test-stable-module-in-pwsh:
    needs: [run-build-and-test, publish-stable-module]
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macOS-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - name: Display PowerShell version being used
        shell: pwsh
        run: $PSVersionTable

      - name: Install stable module from PowerShell Gallery
        shell: pwsh
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $stableVersionNumber = '${{ needs.publish-stable-module.outputs.stableVersionNumber }}'

          Write-Output "Installing the module '$moduleName' stable version '$stableVersionNumber' from the PowerShell Gallery."
          Install-Module -Name $moduleName -RequiredVersion $stableVersionNumber -Force -Scope CurrentUser -Repository PSGallery -ErrorAction Stop -Verbose

      - name: Download deploy files artifact from triggered workflow
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.deployFilesArtifactName}}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Run smoke tests
        shell: pwsh
        run: |
          [string] $smokeTestsScriptPath = "$Env:artifactsDirectoryPath/Invoke-SmokeTests.ps1"

          Write-Output "Running Pester smoke tests from file '$smokeTestsScriptPath'."
          $pesterConfig = New-PesterConfiguration @{
            Output = @{ Verbosity = 'Detailed' }
            Run = @{
              Path = $smokeTestsScriptPath
              Throw = $true
            }
          }
          Invoke-Pester -Configuration $pesterConfig

          Write-Output "Displaying the installed module version that was used for the smoke tests."
          Get-Module -Name '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'

  test-stable-module-in-windows-powershell:
    needs: [run-build-and-test, publish-stable-module]
    runs-on: windows-latest
    steps:
      - name: Display PowerShell version being used
        shell: powershell
        run: $PSVersionTable

      - name: Install stable module from PowerShell Gallery
        shell: powershell
        run: |
          [string] $moduleName = '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
          [string] $stableVersionNumber = '${{ needs.publish-stable-module.outputs.stableVersionNumber }}'

          Write-Output "Installing the module '$moduleName' stable version '$stableVersionNumber' from the PowerShell Gallery."
          Install-Module -Name $moduleName -RequiredVersion $stableVersionNumber -Force -Scope CurrentUser -Repository PSGallery -ErrorAction Stop -Verbose

      - name: Download deploy files artifact from triggered workflow
        uses: actions/download-artifact@v3
        with:
          name: ${{ needs.run-build-and-test.outputs.deployFilesArtifactName}}
          path: ${{ env.artifactsDirectoryPath }}

      - name: Run smoke tests
        shell: powershell
        run: |
          [string] $smokeTestsScriptPath = "$Env:artifactsDirectoryPath/Invoke-SmokeTests.ps1"

          Write-Output "Running Pester smoke tests from file '$smokeTestsScriptPath'."
          $pesterConfig = New-PesterConfiguration @{
            Output = @{ Verbosity = 'Detailed' }
            Run = @{
              Path = $smokeTestsScriptPath
              Throw = $true
            }
          }
          Invoke-Pester -Configuration $pesterConfig

          Write-Output "Displaying the installed module version that was used for the smoke tests."
          Get-Module -Name '${{ needs.run-build-and-test.outputs.powerShellModuleName }}'
