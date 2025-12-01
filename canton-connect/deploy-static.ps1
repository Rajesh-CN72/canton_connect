Write-Host "🚀 DEPLOYING STATIC FILES TO NETLIFY" -ForegroundColor Red
Write-Host ""

Write-Host "1. Building Flutter web app locally..." -ForegroundColor Yellow
flutter clean
flutter pub get
flutter build web --release

Write-Host "2. Creating proper netlify.toml for static site..." -ForegroundColor Yellow
@"
[build]
  publish = "web"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
"@ | Out-File -FilePath "netlify.toml" -Encoding UTF8

Write-Host "3. Moving build files to root web directory..." -ForegroundColor Yellow
# Remove old web directory if exists
Remove-Item -Recurse -Force "web" -ErrorAction SilentlyContinue
# Create web directory
New-Item -ItemType Directory -Path "web" -Force
# Copy build files to web directory
Copy-Item -Path "build/web/*" -Destination "web" -Recurse -Force

Write-Host "4. Deploying static files to Netlify..." -ForegroundColor Yellow
git add .
git commit -m "deploy: static build files for Netlify"
git push origin main

Write-Host ""
Write-Host "✅ Static files deployed! Netlify will now serve pre-built files." -ForegroundColor Green
Write-Host "🌐 Your app: https://visionary-frangipane-926c30.netlify.app" -ForegroundColor Magenta
Write-Host ""
Write-Host "📋 Next step: Update Netlify settings:" -ForegroundColor Cyan
Write-Host "   - Build command: (empty)" -ForegroundColor White
Write-Host "   - Publish directory: web" -ForegroundColor White
Write-Host "   Go to: https://app.netlify.com/sites/visionary-frangipane-926c30/settings/deploys" -ForegroundColor White
