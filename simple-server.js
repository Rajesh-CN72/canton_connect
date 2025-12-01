// simple-server.js - Run this instead of netlify dev
const express = require("express");
const path = require("path");
const app = express();
const PORT = 8888;

app.use(express.json());
app.use(express.static(path.join(__dirname, "build/web")));

// Load functions dynamically
const fs = require("fs");
const functionsPath = path.join(__dirname, "netlify", "functions");

function loadFunction(functionPath) {
  try {
    return require(functionPath);
  } catch (error) {
    console.error(`Error loading function ${functionPath}:`, error.message);
    return null;
  }
}

// Auto-load all functions
function loadAllFunctions() {
  const functionFiles = [];
  
  function walkDir(dir) {
    const files = fs.readdirSync(dir);
    files.forEach(file => {
      const filePath = path.join(dir, file);
      const stat = fs.statSync(filePath);
      if (stat.isDirectory()) {
        walkDir(filePath);
      } else if (file.endsWith(".js") && !file.includes("node_modules")) {
        functionFiles.push(filePath);
      }
    });
  }
  
  if (fs.existsSync(functionsPath)) {
    walkDir(functionsPath);
  }
  
  functionFiles.forEach(file => {
    const relativePath = path.relative(functionsPath, file).replace(/\\/g, "/");
    const routePath = `/.netlify/functions/${relativePath.replace(/\.js$/, "")}`;
    
    const func = loadFunction(file);
    if (func && func.handler) {
      // Register route for all HTTP methods
      app.all(routePath, async (req, res) => {
        try {
          const event = {
            httpMethod: req.method,
            body: JSON.stringify(req.body),
            headers: req.headers,
            path: req.path,
            queryStringParameters: req.query
          };
          
          const result = await func.handler(event, {});
          
          // Handle the response
          if (result.statusCode) {
            res.status(result.statusCode);
            if (result.headers) {
              Object.keys(result.headers).forEach(key => {
                res.setHeader(key, result.headers[key]);
              });
            }
            
            try {
              // Try to parse as JSON, otherwise send as-is
              const parsedBody = JSON.parse(result.body);
              res.json(parsedBody);
            } catch {
              res.send(result.body);
            }
          } else {
            res.json(result);
          }
        } catch (error) {
          console.error(`Error executing ${routePath}:`, error);
          res.status(500).json({ error: error.message });
        }
      });
      
      console.log(`? Loaded function: ${routePath}`);
    }
  });
}

// Load functions
console.log("=== Loading Netlify Functions ===");
loadAllFunctions();

// Default route
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "build/web", "index.html"));
});

// Function list endpoint
app.get("/.netlify/functions", (req, res) => {
  const functions = [];
  const functionFiles = fs.readdirSync(functionsPath, { recursive: true });
  
  functionFiles.forEach(file => {
    if (typeof file === "string" && file.endsWith(".js")) {
      const functionName = file.replace(/\.js$/, "");
      functions.push({
        name: functionName,
        path: `/.netlify/functions/${functionName.replace(/\\/g, "/")}`
      });
    }
  });
  
  res.json({
    message: "Available Functions",
    functions: functions,
    testEndpoints: [
      "POST /.netlify/functions/auth/login - Body: {email, password}",
      "GET /.netlify/functions/menu/items",
      "POST /.netlify/functions/orders/create - Body: {customerName, items}",
      "GET /.netlify/functions/subscription/plans",
      "GET /.netlify/functions/test"
    ]
  });
});

app.listen(PORT, () => {
  console.log(`?? Server running at http://localhost:${PORT}`);
  console.log(`?? Static files from: ${path.join(__dirname, "build/web")}`);
  console.log(`?? Functions from: ${functionsPath}`);
  console.log(`\n?? Test endpoints:`);
  console.log(`   GET  http://localhost:${PORT}/.netlify/functions/test`);
  console.log(`   POST http://localhost:${PORT}/.netlify/functions/auth/login`);
  console.log(`   GET  http://localhost:${PORT}/.netlify/functions/menu/items`);
  console.log(`   POST http://localhost:${Port}/.netlify/functions/orders/create`);
  console.log(`   GET  http://localhost:${Port}/.netlify/functions/subscription/plans`);
  console.log(`\n?? Open in browser: http://localhost:${Port}`);
});
