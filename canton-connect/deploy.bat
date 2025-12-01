@echo off
echo ========================================
echo   Deploying to GitHub: Cantone-Connect
echo ========================================
echo.

echo Step 1: Setting up remote repository...
git remote add origin https://github.com/Rajesh-CN72/Cantone-Connect.git

echo.
echo Step 2: Renaming branch to main...
git branch -M main

echo.
echo Step 3: Pushing to GitHub...
git push -u origin main

echo.
if %errorlevel% equ 0 (
    echo ✅ Successfully pushed to GitHub!
    echo.
    echo 📢 Next Steps:
    echo 1. Go to: https://vercel.com
    echo 2. Sign in with GitHub
    echo 3. Click "Add New Project"
    echo 4. Import repository: Cantone-Connect
    echo 5. Configure:
    echo    - Build Command: flutter build web --release
    echo    - Output Directory: build/web
    echo 6. Click "Deploy"
    echo.
    echo 🌐 Your app will be at: https://cantone-connect.vercel.app
) else (
    echo ❌ Push failed. You may need a Personal Access Token.
    echo.
    echo 🔑 Create token at: https://github.com/settings/tokens
    echo Then run: git remote set-url origin https://Rajesh-CN72:YOUR_TOKEN@github.com/Rajesh-CN72/Cantone-Connect.git
    echo Then run: git push -u origin main
)

echo.
pause
