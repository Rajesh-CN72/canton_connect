exports.handler = async function(event, context) {
  // Handle CORS preflight
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS'
      },
      body: ''
    };
  }
  
  try {
    let data = {};
    if (event.body) {
      data = JSON.parse(event.body);
    }
    
    // Generate order ID
    const orderId = 'ORD-' + Date.now() + '-' + Math.floor(Math.random() * 1000);
    
    // Calculate total
    const items = data.items || [];
    const subtotal = items.reduce((sum, item) => sum + (item.price || 0), 0);
    const tax = subtotal * 0.08;
    const total = subtotal + tax;
    
    const response = {
      success: true,
      message: 'Order placed successfully!',
      orderId: orderId,
      customer: data.customerName || 'Guest Customer',
      items: items,
      summary: {
        subtotal: subtotal.toFixed(2),
        tax: tax.toFixed(2),
        total: total.toFixed(2),
        estimatedDelivery: '30-45 minutes'
      },
      timestamp: new Date().toISOString(),
      status: 'confirmed'
    };
    
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify(response)
    };
  } catch (error) {
    return {
      statusCode: 500,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      },
      body: JSON.stringify({ 
        error: error.message,
        success: false 
      })
    };
  }
}
