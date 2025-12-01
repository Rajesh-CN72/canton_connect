Write-Host "🚀 QUICK FIX FOR NETLIFY 404" -ForegroundColor Red
Write-Host ""

# Create netlify.toml
Write-Host "1. Creating netlify.toml..." -ForegroundColor Yellow
@"
[build]
  publish = "build/web"
  command = "flutter build web --release"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
"@ | Out-File -FilePath "netlify.toml" -Encoding UTF8

Write-Host "2. Building and deploying..." -ForegroundColor Yellow
flutter build web --release
git add .
git commit -m "fix: add netlify.toml for SPA routing"
git push origin main

Write-Host ""
Write-Host "✅ Fix deployed! Wait 2 minutes for auto-deploy." -ForegroundColor Green
Write-Host "🌐 Your app: https://visionary-frangipane-926c30.netlify.app" -ForegroundColor Magenta
