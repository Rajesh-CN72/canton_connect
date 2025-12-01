#!/bin/bash
echo "Starting Netlify build for Canton Connect..."

# Check if we have Flutter web build
if [ -d "canton-connect/build/web" ]; then
    echo "✓ Found Flutter web build in canton-connect/build/web"
    # Copy to root build directory for Netlify
    mkdir -p build
    cp -r canton-connect/build/web/* build/ 2>/dev/null || true
elif [ -d "build/web" ]; then
    echo "✓ Found Flutter web build in build/web"
else
    echo "⚠ No Flutter web build found. Creating placeholder..."
    mkdir -p build/web
    cat > build/web/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Canton Connect</title></head>
<body>
    <h1>Canton Connect API Server</h1>
    <p>Netlify Functions are running.</p>
    <p><a href="/.netlify/functions/test">Test API</a></p>
</body>
</html>
EOF
fi

echo "Build preparation complete!"
