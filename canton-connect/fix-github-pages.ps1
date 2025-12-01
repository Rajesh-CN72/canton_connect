Write-Host "🔧 FIXING GITHUB PAGES ISSUE" -ForegroundColor Red
Write-Host ""

Write-Host "1. Creating _config.yml to disable Jekyll..." -ForegroundColor Yellow
@"
include: [".well-known"]
theme: null
plugins: []
"@ | Out-File -FilePath "docs/_config.yml" -Encoding UTF8

Write-Host "2. Creating .nojekyll file..." -ForegroundColor Yellow
" " | Out-File -FilePath "docs/.nojekyll" -Encoding UTF8

Write-Host "3. Deploying fixes..." -ForegroundColor Yellow
git add .
git commit -m "fix: GitHub Pages configuration"
git push origin main

Write-Host ""
Write-Host "✅ Fix deployed! Wait 5-10 minutes for GitHub Pages to update." -ForegroundColor Green
Write-Host "🌐 Check: https://rajesh-cn72.github.io/Cantone-Connect/" -ForegroundColor Magenta
