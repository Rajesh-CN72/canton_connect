#!/bin/bash
set -e

echo "🚀 Starting Flutter Web Build..."

# Download Flutter with Dart 3.3.0+
echo "📦 Downloading Flutter..."
FLUTTER_VERSION="3.22.0"
wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C /tmp
export PATH="$PATH:/tmp/flutter/bin"

# Setup
echo "🔧 Setting up environment..."
flutter config --no-analytics
flutter config --no-animations
flutter config --enable-web

# Get dependencies
echo "📚 Installing dependencies..."
flutter pub get

# Build
echo "🏗️ Building web app..."
flutter build web --release --no-tree-shake-icons

echo "✅ Build complete! Output: build/web/"
