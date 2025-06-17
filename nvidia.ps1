<#
.SYNOPSIS
    Installs the latest NVIDIA graphics driver for Windows using Chocolatey.
.DESCRIPTION
    - Detects if an NVIDIA GPU is present on the system.
    - Checks if Chocolatey is installed; if not, installs Chocolatey.
    - Determines the latest NVIDIA driver version available from Chocolatey.
    - Installs the driver using Chocolatey.
    - Logs all steps, actions, and results to c:\loggy\nvidia.log (appends if the file exists).
    - Shows progress and stage indicators to the user.
    - Requires administrative privileges and PowerShell 7+.
.NOTES
    Author: Kyle Howard
    Date:   2025-06-09
    Usage: Run this script as Administrator in PowerShell 7+.
#>

$logDir = "C:\loggy"
$logFile = "$logDir\nvidia.log"
if (-not (Test-Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory -Force | Out-Null
}

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp $Message" | Out-File -FilePath $logFile -Append
}

function Show-Stage {
    param([string]$Stage)
    Write-Host ""
    Write-Host "==== $Stage ====" -ForegroundColor Cyan
    Write-Log "STAGE: $Stage"
}

# Add a separator line to the log for each run
$runTimestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$separator = "==================== Script Run: $runTimestamp ===================="
$separator | Out-File -FilePath $logFile -Append

Write-Log "Script started."

Show-Stage "Checking for administrative privileges"
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Log "ERROR: Script not run as Administrator."
    Write-Host "Please run this script as Administrator."
    exit 1
}
Write-Log "Confirmed: Script running as Administrator."

Show-Stage "Detecting NVIDIA GPU"
$gpu = Get-WmiObject Win32_VideoController | Where-Object { $_.Name -like "*NVIDIA*" }
if (-not $gpu) {
    Write-Log "No NVIDIA GPU detected."
    Write-Host "No NVIDIA GPU detected."
    exit 1
}
Write-Log "Detected GPU: $($gpu.Name)"
Write-Host "Detected GPU: $($gpu.Name)"

Show-Stage "Checking for Chocolatey"
if (-not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Write-Log "Chocolatey not found. Installing Chocolatey..."
    Write-Host "Chocolatey not found. Installing Chocolatey... (this may take a moment)"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    try {
        $chocoInstallOutput = Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) 2>&1
        Write-Log "Chocolatey install output: $chocoInstallOutput"
        Write-Log "Chocolatey installed successfully."
        Write-Host "Chocolatey installed successfully."
    } catch {
        Write-Log "ERROR: Failed to install Chocolatey: $_"
        Write-Host "Failed to install Chocolatey. See log for details."
        exit 1
    }
} else {
    Write-Log "Chocolatey is already installed."
    Write-Host "Chocolatey is already installed."
}

Show-Stage "Querying Chocolatey for latest NVIDIA driver version"
$chocoVer = ""
try {
    $chocoInfo = choco info nvidia-display-driver --limit-output | Select-String -Pattern '^nvidia-display-driver'
    if ($chocoInfo) {
        $chocoVer = ($chocoInfo -split '\|')[1].Trim()
        Write-Log "Latest NVIDIA driver version on Chocolatey: $chocoVer"
        Write-Host "Latest NVIDIA driver version on Chocolatey: $chocoVer"
    } else {
        Write-Log "Could not determine NVIDIA driver version from Chocolatey."
        Write-Host "Could not determine NVIDIA driver version from Chocolatey."
    }
} catch {
    Write-Log "ERROR: Could not query Chocolatey for NVIDIA driver version: $_"
    Write-Host "ERROR: Could not query Chocolatey for NVIDIA driver version."
}

Show-Stage "Installing NVIDIA driver from Chocolatey"
if ($chocoVer) {
    Write-Log "Installing NVIDIA driver version $chocoVer from Chocolatey."
    Write-Host "Installing NVIDIA driver version $chocoVer from Chocolatey..."
    try {
        $installArgs = "install nvidia-display-driver --yes --force"
        Write-Log "Running: choco $installArgs"
        $process = Start-Process -FilePath "choco" -ArgumentList $installArgs -Wait -PassThru -NoNewWindow -RedirectStandardOutput "$logDir\choco_output.log" -RedirectStandardError "$logDir\choco_error.log"
        Write-Log "choco exit code: $($process.ExitCode)"
        if (Test-Path "$logDir\choco_output.log") {
            Write-Log "choco output:`n$(Get-Content "$logDir\choco_output.log" -Raw)"
        }
        if (Test-Path "$logDir\choco_error.log") {
            Write-Log "choco error:`n$(Get-Content "$logDir\choco_error.log" -Raw)"
        }
        if ($process.ExitCode -eq 0) {
            Write-Log "NVIDIA driver installed successfully via Chocolatey."
            Write-Host "NVIDIA driver installation completed successfully."
        } else {
            Write-Log "NVIDIA driver installation failed. Exit code: $($process.ExitCode)"
            Write-Host "NVIDIA driver installation failed. See log for details."
            exit 1
        }
    } catch {
        Write-Log "ERROR: Exception during NVIDIA driver installation: $_"
        Write-Host "Error during NVIDIA driver installation. See log for details."
        exit 1
    }
} else {
    Write-Log "No NVIDIA driver version found on Chocolatey. Exiting."
    Write-Host "No NVIDIA driver version found on Chocolatey. Exiting."
    exit 1
}

Show-Stage "Script completed"
Write-Log "Script completed."