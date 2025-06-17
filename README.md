# setup_scripts

This repository contains PowerShell scripts for system setup and automation.

## autoREADME.ps1

**Purpose & Function:**
# "No Info" is listed for that script. # # The script then commits and pushes the updated README.md to the remote repository. # # How it works: # 1. Pulls the latest changes from the remote repository. # 2. Uses 'git ls-files' to find all tracked .ps1 files. # 3. For each file, reads its content and extracts the first documentation block if present. # 4. Builds a Markdown README listing each script and its documentation. # 5. Overwrites README.md with the new content. # 6. Commits and pushes the README.md to the remote repository.  # Update local repository git pull  # Get all .ps1 files tracked by git in the repo $ps1Files = git ls-files "*.ps1" | ForEach-Object { Get-Item $_ }  # Prepare documentation lines $docLines = @() foreach ($file in $ps1Files) { # Read the file content $lines = Get-Content $file.FullName  $docBlock = @() $inDocBlock = $false foreach ($line in $lines) { $inDocBlock = $true continue } if ($inDocBlock) {

**Requirements:**
None specified.

## choco.ps1

**Purpose & Function:**
No description found.

**Requirements:**
None specified.

## cygwin.ps1

**Purpose & Function:**
cygwin.ps1 This script checks if Cygwin is installed and installs it if missing. All actions and errors are logged to C:\loggy\cygwin.log. A progress bar is shown during setup steps.

**Requirements:**
None specified.

## git.ps1

**Purpose & Function:**
git.ps1 This script checks if Git is installed on the system and installs it if missing. All actions and errors are logged to C:\loggy\git.log. Inline remarks describe each step. See the end of the file for usage instructions and theory of operation.

**Requirements:**
None specified.

## githubby.ps1

**Purpose & Function:**
githubby.ps1 This script pushes all scripts in the current directory to the GitHub repository https://github.com/kylehoward/setup_scripts.git, committing them if needed. It also updates the README.md file in the repository to document each script's purpose, All actions and errors are logged to C:\loggy\githubby.log.

**Requirements:**
function, and requirements (based on comments in each script). Requires: git, and write access to the repository (SSH or HTTPS credentials set up).

## nvidia.ps1

**Purpose & Function:**
.SYNOPSIS Installs the latest NVIDIA graphics driver for Windows using Chocolatey. .DESCRIPTION - Detects if an NVIDIA GPU is present on the system. - Checks if Chocolatey is installed; if not, installs Chocolatey. - Determines the latest NVIDIA driver version available from Chocolatey. - Installs the driver using Chocolatey. - Logs all steps, actions, and results to c:\loggy\nvidia.log (appends if the file exists). - Shows progress and stage indicators to the user. .NOTES Author: Kyle Howard Date:   2025-06-09 Usage: Run this script as Administrator in PowerShell 7+.

**Requirements:**
- Requires administrative privileges and PowerShell 7+.

## powersh.ps1

**Purpose & Function:**
No description found.

**Requirements:**
None specified.

## shellie.ps1

**Purpose & Function:**
shellie.ps1 This script checks if oh-my-posh is configured as the default prompt for PowerShell 7 (all users). If not, it installs oh-my-posh, sets up a theme, and updates the all-users profile. All progress and results are logged to C:\loggy\shellie.log. A progress bar is shown during setup steps.

**Requirements:**
None specified.

## tabby-web.ps1

**Purpose & Function:**
File: tabby-web.ps1 Author: AI (GitHub Copilot) for Kyle Howard  Description: This script sets up and runs the Tabby Web terminal server using Docker. - Checks for and ensures Docker Desktop is running throughout execution - Clones the tabby-web repository from GitHub - Builds and runs the Docker container for Tabby Web terminal server - Server will be available at http://localhost:8080 when complete  Usage: .\tabby-web.ps1 .\tabby-web.ps1 -Stop .\tabby-web.ps1 -Restart .\tabby-web.ps1 -Remove

**Requirements:**
None specified.

## todoist.ps1

**Purpose & Function:**
No description found.

**Requirements:**
None specified.

