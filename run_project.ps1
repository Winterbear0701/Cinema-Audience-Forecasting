# Cinema Audience Forecasting - Run Script
# Quick execution script for the complete pipeline

Write-Host "🎬 Cinema Audience Forecasting Pipeline" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-Not (Test-Path ".\theatre\Scripts\Activate.ps1")) {
    Write-Host "❌ Virtual environment not found!" -ForegroundColor Red
    Write-Host "Please create it first:" -ForegroundColor Yellow
    Write-Host "  python -m venv theatre" -ForegroundColor Yellow
    Write-Host "  .\theatre\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host "  pip install -r requirements.txt" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Activating virtual environment..." -ForegroundColor Green
& ".\theatre\Scripts\Activate.ps1"

Write-Host "✅ Checking dependencies..." -ForegroundColor Green
$packages = @("pandas", "numpy", "lightgbm", "xgboost", "optuna", "jupyter")
foreach ($pkg in $packages) {
    $installed = pip show $pkg 2>$null
    if ($installed) {
        Write-Host "  ✓ $pkg installed" -ForegroundColor DarkGray
    } else {
        Write-Host "  ✗ $pkg missing - installing..." -ForegroundColor Yellow
        pip install $pkg -q
    }
}

Write-Host ""
Write-Host "✅ All dependencies ready!" -ForegroundColor Green
Write-Host ""

# Ask user what to do
Write-Host "What would you like to do?" -ForegroundColor Cyan
Write-Host "1. Open Jupyter Lab (Interactive)" -ForegroundColor White
Write-Host "2. Run complete pipeline (Console)" -ForegroundColor White
Write-Host "3. View project documentation" -ForegroundColor White
Write-Host "4. Check submission files" -ForegroundColor White
Write-Host "Q. Quit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice (1-4, Q)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "🚀 Opening Jupyter Lab..." -ForegroundColor Green
        Write-Host "The notebook will open in your browser" -ForegroundColor Yellow
        Write-Host ""
        Set-Location "Cinema-Audiance\code"
        jupyter lab working-1.ipynb
    }
    "2" {
        Write-Host ""
        Write-Host "🚀 Running complete pipeline..." -ForegroundColor Green
        Write-Host "This will take 10-15 minutes..." -ForegroundColor Yellow
        Write-Host ""
        Set-Location "Cinema-Audiance\code"
        jupyter nbconvert --to notebook --execute working-1.ipynb --output executed.ipynb
        Write-Host ""
        Write-Host "✅ Pipeline completed!" -ForegroundColor Green
        Write-Host "Check Cinema-Audiance\ for submission files" -ForegroundColor Yellow
    }
    "3" {
        Write-Host ""
        Write-Host "📚 Opening documentation..." -ForegroundColor Green
        code "Cinema-Audiance\README.md"
        code "Cinema-Audiance\QUICKSTART.md"
        code "Cinema-Audiance\PROJECT_REPORT.md"
    }
    "4" {
        Write-Host ""
        if (Test-Path "Cinema-Audiance\submission_*.csv") {
            Write-Host "✅ Submission files found:" -ForegroundColor Green
            Get-ChildItem "Cinema-Audiance\submission_*.csv" | ForEach-Object {
                Write-Host "  - $($_.Name) ($([math]::Round($_.Length/1KB, 2)) KB)" -ForegroundColor White
            }
            Write-Host ""
            Write-Host "Preview of submission_ensemble_v1.csv:" -ForegroundColor Cyan
            Get-Content "Cinema-Audiance\submission_ensemble_v1.csv" -TotalCount 10
        } else {
            Write-Host "❌ No submission files found yet." -ForegroundColor Red
            Write-Host "Run the pipeline first (option 1 or 2)" -ForegroundColor Yellow
        }
    }
    "Q" {
        Write-Host ""
        Write-Host "👋 Goodbye!" -ForegroundColor Cyan
        exit 0
    }
    default {
        Write-Host ""
        Write-Host "❌ Invalid choice" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "✅ Done!" -ForegroundColor Green
Write-Host ""
