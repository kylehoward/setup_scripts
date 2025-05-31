<#
    githubby.ps1
    This script pushes all scripts in the current directory to the GitHub repository
    https://github.com/kylehoward/setup_scripts.git, committing them if needed.
    It also updates the README.md file in the repository to document each script's purpose,
    function, and requirements (based on comments in each script).
    All actions and errors are logged to C:\loggy\githubby.log.
    Requires: git, and write access to the repository (SSH or HTTPS credentials set up).
#>

# --- Logging setup ---
$logPath = "C:\loggy\githubby.log"
if (!(Test-Path (Split-Path $logPath))) {
    New-Item -ItemType Directory -Path (Split-Path $logPath) -Force | Out-Null
}
function Write-Log {
    param([string]$msg)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp $msg" | Out-File -FilePath $logPath -Append
}

Write-Log "=== Starting GitHub push ==="

# --- Variables ---
$repoUrl = "https://github.com/kylehoward/setup_scripts.git"
$repoName = "setup_scripts"
$cwd = Get-Location

# --- Ensure git is available ---
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "git is not installed or not in PATH. Aborting."
    Write-Log "git is not installed or not in PATH. Aborting."
    exit 1
}

# --- Clone or use existing repo ---
if (-not (Test-Path ".git")) {
    Write-Log "No .git directory found. Cloning repository..."
    git clone $repoUrl . | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to clone repository."
        Write-Log "Failed to clone repository."
        exit 1
    }
} else {
    Write-Log "Existing git repository found. Pulling latest changes..."
    git pull | Out-Null
}

# --- Add all scripts in current directory ---
$scriptFiles = Get-ChildItem -Path $cwd -Filter "*.ps1" -File
foreach ($file in $scriptFiles) {
    git add $file.Name
    Write-Log "Added $($file.Name) to git staging."
}

# --- Update README.md ---
$readmePath = Join-Path $cwd "README.md"
$readmeContent = @("# setup_scripts", "", "This repository contains PowerShell scripts for system setup and automation.", "")

foreach ($file in $scriptFiles) {
    $lines = Get-Content $file.FullName
    $desc = ""
    $reqs = ""
    $inBlock = $false
    foreach ($line in $lines) {
        if ($line -match "<#") { $inBlock = $true; continue }
        if ($line -match "#>") { $inBlock = $false; break }
        if ($inBlock) {
            if ($line -match "require" -or $line -match "Require") { $reqs += ($line.Trim() + " ") }
            else { $desc += ($line.Trim() + " ") }
        }
    }
    $descText = if ($desc) { $desc.Trim() } else { "No description found." }
    $reqsText = if ($reqs) { $reqs.Trim() } else { "None specified." }
    $readmeContent += @(
        "## $($file.Name)",
        "",
        "**Purpose & Function:**",
        $descText,
        "",
        "**Requirements:**",
        $reqsText,
        ""
    )
}

Set-Content -Path $readmePath -Value $readmeContent
git add README.md
Write-Log "Updated README.md with script documentation."

# --- Commit and push ---
$commitMsg = "Add/update scripts and README on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m "$commitMsg"
if ($LASTEXITCODE -eq 0) {
    Write-Log "Committed changes: $commitMsg"
    git push
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Scripts and README pushed to GitHub successfully."
        Write-Log "Scripts and README pushed to GitHub successfully."
    } else {
        Write-Host "Failed to push to GitHub."
        Write-Log "Failed to push to GitHub."
    }
} else {
    Write-Host "No changes to commit."
    Write-Log "No changes to commit."
}

<#
-------------------------------
Instructions for Use:
-------------------------------
- Place this script in the directory with your .ps1 scripts.
- Run as a user with git and GitHub push access.
- The script will add all .ps1 files, update the README.md, commit, and push.

-------------------------------
Theory of Operation:
-------------------------------
- The script ensures a git repo is present and up to date.
- It stages all PowerShell scripts, updates the README.md with descriptions and requirements
  (parsed from comment blocks), commits, and pushes to the remote repository.
- All actions and errors are logged to C:\loggy\githubby.log.
#>