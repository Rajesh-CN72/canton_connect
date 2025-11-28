@echo off
echo ========================================
echo   FIXED DEPLOYMENT - Canton Connect
echo ========================================
echo.

echo 🛠️ Step 1: Creating fixed vercel.json...
echo {
echo   "version": 2,
echo   "builds": [
echo     {
echo       "src": "build/web/**/*",
echo       "use": "@vercel/static"
echo     }
echo   ],
echo   "routes": [
echo     {
echo       "src": "/(.*)",
echo       "dest": "/index.html"
echo     }
echo   ]
echo } > vercel.json

echo.
echo ✅ Created fixed vercel.json
echo.
echo 🧹 Step 2: Cleaning and building...
flutter clean
flutter pub get
flutter build web --release

if %errorlevel% neq 0 (
    echo ❌ Build failed!
    pause
    exit /b 1
)

echo.
echo 📦 Step 3: Pushing to GitHub...
git add .
git commit -m "fix: correct vercel.json configuration" || echo ⚠️ No changes to commit
git push origin main

echo.
echo ✅ Code pushed to GitHub!
echo.
echo 🗑️ Step 4: Delete old Vercel project (if needed):
echo 1. Go to: https://vercel.com/dashboard
echo 2. Find and delete any old ""canton-connect"" project
echo.
echo 🚀 Step 5: Fresh deployment:
echo 1. Go to: https://vercel.com/import
echo 2. Select: Cantone-Connect
echo 3. Configure:
echo    - Project Name: canton-connect
echo    - Build Command: flutter build web --release
echo    - Output Directory: build/web
echo 4. Click ""Deploy""
echo.
echo 🌐 Your app will be at: https://canton-connect.vercel.app
echo.
pause
