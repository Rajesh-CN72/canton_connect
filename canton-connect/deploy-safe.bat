@echo off
echo ========================================
echo   Safe Deployment: Cantone-Connect
echo ========================================
echo.

echo 🔍 Step 1: Checking Flutter installation...
flutter --version
if %errorlevel% neq 0 (
    echo ❌ Flutter not found. Please check Flutter installation.
    pause
    exit /b 1
)

echo.
echo 🛠️ Step 2: Building Flutter web app...
flutter clean
flutter pub get
flutter build web --release

if %errorlevel% neq 0 (
    echo ❌ Flutter build failed!
    echo Common fixes:
    echo - Run 'flutter doctor'
    echo - Check internet connection
    echo - Try 'flutter pub get' manually
    pause
    exit /b 1
)

echo.
echo ✅ Build successful! Checking build files...
if not exist "build\web\index.html" (
    echo ❌ Build files missing!
    pause
    exit /b 1
)

echo.
echo 📦 Step 3: Preparing for GitHub...
git add .
git commit -m "deploy: Flutter web build for Vercel" || (
    echo ⚠️ No changes to commit or commit failed
)

echo.
echo 🚀 Step 4: Pushing to GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo.
    echo ❌ GitHub push failed. Setting up remote...
    git remote remove origin
    git remote add origin https://github.com/Rajesh-CN72/Cantone-Connect.git
    git branch -M main
    git push -u origin main
)

if %errorlevel% equ 0 (
    echo.
    echo ✅ Successfully pushed to GitHub!
    echo.
    echo 🌐 Deployment Instructions:
    echo 1. Go to: https://vercel.com/import
    echo 2. Sign in with GitHub
    echo 3. Select repository: Cantone-Connect
    echo 4. Configure:
    echo    - Framework: Other
    echo    - Build Command: flutter build web --release
    echo    - Output Directory: build/web
    echo 5. Click "Deploy"
    echo.
    echo 📝 If deployment fails on Vercel:
    echo - Check build logs in Vercel dashboard
    echo - Ensure vercel.json is in root directory
    echo - Verify build/web contains index.html
) else (
    echo.
    echo ❌ GitHub setup failed. Manual steps required.
    echo.
    echo 🔧 Manual GitHub Setup:
    echo 1. Go to: https://github.com/Rajesh-CN72/Cantone-Connect
    echo 2. Follow instructions to push existing repository
    echo.
    echo Or use these commands manually:
    echo git remote add origin https://github.com/Rajesh-CN72/Cantone-Connect.git
    echo git branch -M main
    echo git push -u origin main
)

echo.
pause
