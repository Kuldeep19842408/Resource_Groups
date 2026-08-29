# =========================================================
# Security & Code Quality Scanner Script (Root Level)
# Tools: Gitleaks, TFSec, TFLint, Checkov
# =========================================================

param (
    [string]$TargetFolder = "."
)

# 1. Ensure local tools are appended to PATH if they exist on Windows
$ToolPaths = @(
    "C:\Users\DELL\AppData\Local\Programs\Python\Python312",
    "C:\Users\DELL\AppData\Local\Programs\Python\Python312\Scripts",
    "C:\Devops\Tool\terraform_1.14.6_windows_amd64"
)

foreach ($path in $ToolPaths) {
    if ((Test-Path $path) -and ($env:PATH -notlike "*$path*")) {
        $env:PATH = "$path;" + $env:PATH
    }
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   Running Security & Governance Scan on: $TargetFolder   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Resolve target directory (auto-detect Infra29082026 if present)
$ResolvedTarget = $TargetFolder
if (-not (Test-Path "$ResolvedTarget\preprod") -and (Test-Path "$ResolvedTarget\Infra29082026")) {
    $ResolvedTarget = "$TargetFolder\Infra29082026"
}

# 2. Gitleaks (Secret & Credential Detection)
Write-Host "`n[1/4] Running Gitleaks (Secret Detection)..." -ForegroundColor Yellow
if (Get-Command gitleaks -ErrorAction SilentlyContinue) {
    gitleaks detect --source $TargetFolder --verbose
} else {
    Write-Host "Gitleaks not found in PATH, skipping." -ForegroundColor Gray
}

# 3. TFSec (Terraform Static Code Analysis)
Write-Host "`n[2/4] Running TFSec (Terraform Security)..." -ForegroundColor Yellow
if (Get-Command tfsec -ErrorAction SilentlyContinue) {
    if (Test-Path "$ResolvedTarget\preprod") {
        Write-Host "--- Scanning preprod ---" -ForegroundColor DarkCyan
        if (Test-Path "$ResolvedTarget\preprod\terraform.tfvars") {
            tfsec "$ResolvedTarget\preprod" --tfvars-file "$ResolvedTarget\preprod\terraform.tfvars"
        } else {
            tfsec "$ResolvedTarget\preprod"
        }
    }
    if (Test-Path "$ResolvedTarget\Prod") {
        Write-Host "--- Scanning Prod ---" -ForegroundColor DarkCyan
        if (Test-Path "$ResolvedTarget\Prod\terraform.tfvars") {
            tfsec "$ResolvedTarget\Prod" --tfvars-file "$ResolvedTarget\Prod\terraform.tfvars"
        } else {
            tfsec "$ResolvedTarget\Prod"
        }
    }
    if (Test-Path "$ResolvedTarget\Modules") {
        Write-Host "--- Scanning Modules (Sub-directories) ---" -ForegroundColor DarkCyan
        $SubModules = Get-ChildItem -Path "$ResolvedTarget\Modules" -Directory
        foreach ($mod in $SubModules) {
            Write-Host " Scanning Module: $($mod.Name)" -ForegroundColor DarkGray
            tfsec $mod.FullName
        }
    }
} else {
    Write-Host "TFSec not found in PATH, skipping." -ForegroundColor Gray
}

# 4. TFLint (Terraform Linter)
Write-Host "`n[3/4] Running TFLint (Terraform Linter)..." -ForegroundColor Yellow
if (Get-Command tflint -ErrorAction SilentlyContinue) {
    tflint --chdir=$ResolvedTarget
} else {
    Write-Host "TFLint not found in PATH, skipping." -ForegroundColor Gray
}

# 5. Checkov (Infrastructure as Code Security)
Write-Host "`n[4/4] Running Checkov (Policy & Compliance)..." -ForegroundColor Yellow
if (Get-Command checkov -ErrorAction SilentlyContinue) {
    checkov -d $ResolvedTarget --framework terraform
} elseif (Get-Command python.exe -ErrorAction SilentlyContinue) {
    python.exe -m checkov.main -d $ResolvedTarget --framework terraform
} elseif (Test-Path "C:\Users\DELL\AppData\Local\Programs\Python\Python312\python.exe") {
    & "C:\Users\DELL\AppData\Local\Programs\Python\Python312\python.exe" -m checkov.main -d $ResolvedTarget --framework terraform
} else {
    Write-Host "Checkov / Python not found in PATH, skipping." -ForegroundColor Gray
}



Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host "   Security scan execution completed!                    " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Green

