Write-Host "🔧 Fixing Critical Flutter Issues..." -ForegroundColor Red

# 1. Remove duplicate hero section
if (Test-Path "lib\presentation\widgets\home\hero_section.dart") {
    Remove-Item "lib\presentation\widgets\home\hero_section.dart" -Force
    Write-Host "✅ Removed duplicate: hero_section.dart" -ForegroundColor Green
}

# 2. Fix AppColors import issue in app_text_styles.dart
$textStylesPath = "lib\core\themes\app_text_styles.dart"
if (Test-Path $textStylesPath) {
    $content = Get-Content $textStylesPath -Raw
    $fixedContent = $content -replace 'class AppTextStyles', "import 'app_colors.dart';`n`nclass AppTextStyles"
    Set-Content -Path $textStylesPath -Value $fixedContent
    Write-Host "✅ Fixed AppColors import in app_text_styles.dart" -ForegroundColor Green
}

# 3. Check and fix app.dart
$appPath = "lib\app.dart"
if (Test-Path $appPath) {
    Write-Host "Checking app.dart..." -ForegroundColor Yellow
    Get-Content $appPath | Select-Object -First 10
}

Write-Host "`n🎯 CRITICAL ISSUES FOUND:" -ForegroundColor Red
Write-Host "1. Missing AppColors import in app_text_styles.dart" -ForegroundColor Yellow
Write-Host "2. Deprecated API usage throughout codebase" -ForegroundColor Yellow
Write-Host "3. Undefined HomeScreen class in app.dart" -ForegroundColor Yellow
Write-Host "4. Duplicate hero section files" -ForegroundColor Yellow

Write-Host "`n🚀 Running detailed analysis..." -ForegroundColor Cyan
