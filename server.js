const express = require('express');
const cors = require('cors');
const app = express();
require('dotenv').config();

// Middleware
app.use(cors());
app.use(express.json());

// Test endpoint
app.get('/.netlify/functions/test', (req, res) => {
    res.json({ 
        message: 'Server is working!',
        timestamp: new Date().toISOString(),
        environment: process.env.NODE_ENV || 'development'
    });
});

// Login endpoint
app.post('/.netlify/functions/auth/login', (req, res) => {
    const { email, password } = req.body;
    
    // Simple authentication (replace with real auth)
    if (email === 'admin@example.com' && password === 'admin123') {
        res.json({
            success: true,
            message: 'Login successful',
            token: 'fake-jwt-token-123456',
            user: {
                id: 1,
                email: email,
                name: 'Admin User',
                role: 'admin'
            }
        });
    } else {
        res.status(401).json({
            success: false,
            message: 'Invalid credentials'
        });
    }
});

// Menu items endpoint
app.get('/.netlify/functions/menu/items', (req, res) => {
    res.json({
        items: [
            { id: 1, name: 'Dim Sum Platter', price: 25.99, category: 'Appetizer' },
            { id: 2, name: 'Spring Rolls', price: 8.99, category: 'Appetizer' },
            { id: 3, name: 'Sweet and Sour Chicken', price: 15.99, category: 'Main Course' },
            { id: 4, name: 'Beef with Broccoli', price: 16.99, category: 'Main Course' },
            { id: 5, name: 'Fried Rice', price: 12.99, category: 'Side' }
        ]
    });
});

// Subscription plans
app.get('/.netlify/functions/subscription/plans', (req, res) => {
    res.json({
        plans: [
            { id: 1, name: 'Basic', price: 9.99, features: ['5 meals/week', 'Basic support'] },
            { id: 2, name: 'Premium', price: 19.99, features: ['10 meals/week', 'Priority support', 'Free delivery'] },
            { id: 3, name: 'Family', price: 29.99, features: ['20 meals/week', '24/7 support', 'Free delivery', 'Custom menu'] }
        ]
    });
});

// Create order
app.post('/.netlify/functions/orders/create', (req, res) => {
    const { customerName, items } = req.body;
    
    if (!customerName || !items || !Array.isArray(items)) {
        return res.status(400).json({
            success: false,
            message: 'Invalid order data'
        });
    }
    
    const total = items.reduce((sum, item) => sum + (item.price || 0), 0);
    
    res.json({
        success: true,
        orderId: 'ORD-' + Date.now(),
        customerName,
        items,
        total: parseFloat(total.toFixed(2)),
        status: 'confirmed',
        estimatedDelivery: new Date(Date.now() + 45 * 60000).toISOString() // 45 minutes from now
    });
});

// Profile endpoint
app.get('/.netlify/functions/auth/profile', (req, res) => {
    // Check for auth header
    const token = req.headers.authorization;
    
    if (!token || !token.includes('fake-jwt-token')) {
        return res.status(401).json({
            success: false,
            message: 'Not authenticated'
        });
    }
    
    res.json({
        success: true,
        user: {
            id: 1,
            email: 'admin@example.com',
            name: 'Admin User',
            role: 'admin',
            subscription: 'Premium',
            joinDate: '2024-01-15'
        }
    });
});

// Logout
app.post('/.netlify/functions/auth/logout', (req, res) => {
    res.json({
        success: true,
        message: 'Logged out successfully'
    });
});

// Register
app.post('/.netlify/functions/auth/register', (req, res) => {
    const { email, password, name } = req.body;
    
    if (!email || !password || !name) {
        return res.status(400).json({
            success: false,
            message: 'Missing required fields'
        });
    }
    
    res.json({
        success: true,
        message: 'Registration successful',
        user: {
            email,
            name,
            id: Date.now() // Simulate user ID
        },
        token: 'fake-jwt-token-new-user'
    });
});

// Health check
app.get('/health', (req, res) => {
    res.json({ status: 'ok', timestamp: new Date().toISOString() });
});

// Root endpoint
app.get('/', (req, res) => {
    res.json({
        message: 'Canton Connect API',
        version: '1.0.0',
        endpoints: [
            'GET  /.netlify/functions/test',
            'POST /.netlify/functions/auth/login',
            'GET  /.netlify/functions/menu/items',
            'POST /.netlify/functions/orders/create',
            'GET  /.netlify/functions/auth/profile'
        ]
    });
});

const PORT = process.env.PORT || 8888;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
    console.log(`API Base URL: http://localhost:${PORT}`);
    console.log(`Test endpoint: http://localhost:${PORT}/.netlify/functions/test`);
});
