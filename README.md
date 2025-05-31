# setup_scripts

This repository contains PowerShell scripts for system setup and automation.

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

