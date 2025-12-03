#!/bin/bash

# Exit on error
set -e

echo "========================================"
echo "Flutter Web Build for Cloudflare Pages"
echo "========================================"

# Install Flutter
FLUTTER_VERSION="3.16.0"
echo "📦 Installing Flutter $FLUTTER_VERSION..."

# Download and extract Flutter
wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C /tmp

# Add Flutter to PATH
export PATH="$PATH:/tmp/flutter/bin"

# Verify Flutter installation
echo "✅ Flutter installed:"
flutter --version

# Enable web support
echo "🔧 Setting up Flutter web..."
flutter config --enable-web

# Install dependencies
echo "📚 Getting dependencies..."
flutter pub get

# Build web app
echo "🚀 Building web app..."
flutter build web --release --base-href /

echo "========================================"
echo "✅ Build completed successfully!"
echo "Output: build/web/"
echo "========================================"
