#!/bin/bash
echo "🚀 Starting Canton Connect deployment..."

# Install Flutter if not present
if ! command -v flutter &> /dev/null; then
    echo "Installing Flutter..."
    git clone https://github.com/flutter/flutter.git --depth 1 -b stable
    export PATH="$PATH:`pwd`/flutter/bin"
fi

# Check Flutter version
flutter --version

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Build web app
echo "Building Flutter web app..."
flutter build web --release --web-renderer html

# Check if build was successful
if [ -d "build/web" ]; then
    echo "✅ Build successful!"
    echo "📁 Build directory: build/web"
    ls -la build/web/
else
    echo "❌ Build failed!"
    exit 1
fi
