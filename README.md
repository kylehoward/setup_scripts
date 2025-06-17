# PowerShell Scripts Documentation
README last updated on 2025-06-17 15:59:52 by autoREADME.ps1 script.
This file lists all PowerShell scripts and their documentation blocks as of the last commit.

Each script and its documentation block are listed below:
* **choco.ps1**: No Info
* **cygwin.ps1**: cygwin.ps1 This script checks if Cygwin is installed and installs it if missing. All actions and errors are logged to C:\loggy\cygwin.log. A progress bar is shown during setup steps.
* **git.ps1**: git.ps1 This script checks if Git is installed on the system and installs it if missing. All actions and errors are logged to C:\loggy\git.log. Inline remarks describe each step. See the end of the file for usage instructions and theory of operation.
* **githubby.ps1**: githubby.ps1 This script pushes all scripts in the current directory to the GitHub repository https://github.com/kylehoward/setup_scripts.git, committing them if needed. It also updates the README.md file in the repository to document each script's purpose, function, and requirements (based on comments in each script). All actions and errors are logged to C:\loggy\githubby.log. Requires: git, and write access to the repository (SSH or HTTPS credentials set up).
* **nvidia.ps1**: .SYNOPSIS Installs the latest NVIDIA graphics driver for Windows using Chocolatey. .DESCRIPTION - Detects if an NVIDIA GPU is present on the system. - Checks if Chocolatey is installed; if not, installs Chocolatey. - Determines the latest NVIDIA driver version available from Chocolatey. - Installs the driver using Chocolatey. - Logs all steps, actions, and results to c:\loggy\nvidia.log (appends if the file exists). - Shows progress and stage indicators to the user. - Requires administrative privileges and PowerShell 7+. .NOTES Author: Kyle Howard Date:   2025-06-09 Usage: Run this script as Administrator in PowerShell 7+.
* **powersh.ps1**: No Info
* **shellie.ps1**: shellie.ps1 This script checks if oh-my-posh is configured as the default prompt for PowerShell 7 (all users). If not, it installs oh-my-posh, sets up a theme, and updates the all-users profile. All progress and results are logged to C:\loggy\shellie.log. A progress bar is shown during setup steps.
* **tabby-web.ps1**: File: tabby-web.ps1 Author: AI (GitHub Copilot) for Kyle Howard  Description: This script sets up and runs the Tabby Web terminal server using Docker. - Checks for and ensures Docker Desktop is running throughout execution - Clones the tabby-web repository from GitHub - Builds and runs the Docker container for Tabby Web terminal server - Server will be available at http://localhost:8080 when complete  Usage: .\tabby-web.ps1 .\tabby-web.ps1 -Stop .\tabby-web.ps1 -Restart .\tabby-web.ps1 -Remove
* **todoist.ps1**: No Info

