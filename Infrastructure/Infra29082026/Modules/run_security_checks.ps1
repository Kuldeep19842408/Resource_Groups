# =========================================================
# Security & Code Quality Scanner Script for Modules Directory
# Tools: Gitleaks, TFSec, TFLint, Checkov
# =========================================================

# Ensure tool paths are in PATH
$ToolPaths = @(
    "C:\Users\DELL\AppData\Local\Programs\Python\Python312",
    "C:\Users\DELL\AppData\Local\Programs\Python\Python312\Scripts",
    "C:\Devops\Tool\terraform_1.14.6_windows_amd64"
)

foreach ($path in $ToolPaths) {
    if ($env:PATH -notlike "*$path*") {
        $env:PATH = "$path;" + $env:PATH
    }
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " 1. Running Gitleaks on Modules          " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
gitleaks detect --source . --verbose

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 2. Running TFSec on Each Module          " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$ModuleDirs = Get-ChildItem -Directory
foreach ($dir in $ModuleDirs) {
    Write-Host "`n---> Scanning Module: $($dir.Name)" -ForegroundColor DarkCyan
    tfsec $dir.FullName
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 3. Running TFLint on Modules             " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
if (Get-Command tflint -ErrorAction SilentlyContinue) {
    tflint --recursive
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 4. Running Checkov on Modules            " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
& "C:\Users\DELL\AppData\Local\Programs\Python\Python312\python.exe" -m checkov.main -d . --framework terraform

Write-Host "`n==========================================" -ForegroundColor Green
Write-Host "   Modules Security Scan Completed!       " -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
