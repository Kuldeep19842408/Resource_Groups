# Add paths for security tools
$env:PATH = "C:\Users\DELL\AppData\Local\Programs\Python\Python312;C:\Users\DELL\AppData\Local\Programs\Python\Python312\Scripts;C:\Devops\Tool\terraform_1.14.6_windows_amd64;" + $env:PATH

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " 1. Running Gitleaks (Secret Detection) " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
gitleaks detect --source . --verbose

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 2. Running TFSec (Terraform Security)  " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
tfsec . --tfvars-file terraform.tfvars

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 3. Running TFLint (Terraform Linter)   " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
tflint

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " 4. Running Checkov (Policy & Compliance)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
& "C:\Users\DELL\AppData\Local\Programs\Python\Python312\python.exe" -m checkov.main -d . --framework terraform
