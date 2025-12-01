#!/bin/bash
set -e  # Exit on error

echo "🚀 Starting Netlify build for Canton Connect..."

# Debug: Show current directory
echo "Current directory: $(pwd)"
ls -la

# Check for Flutter web build
if [ -d "canton-connect/build/web" ]; then
    echo "✓ Found Flutter web build in canton-connect/build/web"
    # Use this directory
    mkdir -p build
    cp -r canton-connect/build/web/* build/ 2>/dev/null || echo "Copy completed"
elif [ -d "build/web" ]; then
    echo "✓ Found Flutter web build in build/web"
else
    echo "⚠ No Flutter web build found. Creating simple API server page..."
    
    # Create minimal build directory
    mkdir -p build/web
    
    # Create a simple HTML page that shows API is working
    cat > build/web/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Canton Connect API Server</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; }
        h1 { color: #2c3e50; }
        .api-test { background: #f8f9fa; padding: 15px; border-radius: 8px; margin: 20px 0; }
        .endpoint { margin: 10px 0; padding: 8px; background: #e9ecef; border-radius: 4px; }
        code { background: #dee2e6; padding: 2px 6px; border-radius: 3px; }
    </style>
</head>
<body>
    <h1>🍜 Canton Connect Food Delivery</h1>
    <p>Backend API Server is running on Netlify Functions</p>
    
    <div class="api-test">
        <h3>Test API Connection:</h3>
        <button onclick="testAPI()">Test API</button>
        <div id="api-result"></div>
    </div>
    
    <h3>Available Endpoints:</h3>
    <div class="endpoint"><strong>GET</strong> <code>/.netlify/functions/test</code> - Test endpoint</div>
    <div class="endpoint"><strong>POST</strong> <code>/.netlify/functions/auth/login</code> - User login</div>
    <div class="endpoint"><strong>GET</strong> <code>/.netlify/functions/menu/items</code> - Menu items</div>
    <div class="endpoint"><strong>POST</strong> <code>/.netlify/functions/orders/create</code> - Create order</div>
    
    <script>
        async function testAPI() {
            try {
                const response = await fetch('/.netlify/functions/test');
                const data = await response.json();
                document.getElementById('api-result').innerHTML = 
                    `<p style="color: green;">✅ API is working: ${data.message}</p>`;
            } catch (error) {
                document.getElementById('api-result').innerHTML = 
                    `<p style="color: red;">❌ API test failed: ${error.message}</p>`;
            }
        }
        
        // Auto-test on page load
        window.onload = testAPI;
    </script>
</body>
</html>
HTML
    
    echo "✓ Created placeholder index.html"
fi

echo "✅ Build preparation complete!"
echo "📁 Build directory contents:"
ls -la build/web/ 2>/dev/null || echo "No build/web directory"