#!/bin/bash

set -e  # Exit immediately if any command fails

echo "========================================"
echo "Flutter Web Build for Cloudflare Pages"
echo "========================================"

echo "📦 Installing Flutter 3.22.0..."
git clone https://github.com/flutter/flutter.git -b 3.22.0
export PATH="$PATH:$(pwd)/flutter/bin"

echo "✅ Flutter installed:"
flutter --version

echo "🔧 Setting up Flutter web..."
flutter config --enable-web

echo "📚 Getting dependencies..."
flutter pub get

echo "🔨 Building web app..."
flutter build web --release --web-renderer html --no-tree-shake-icons

echo "📦 Copying to public directory..."
mkdir -p ./public
cp -r build/web/* ./public/

echo "✅ Build completed! Files ready in ./public/"
