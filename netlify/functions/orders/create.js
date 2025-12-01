exports.handler = async (event, context) => {
  // Handle CORS preflight
  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE'
      },
      body: ''
    };
  }
  
  try {
    let data = {};
    if (event.body) {
      data = JSON.parse(event.body);
    }
    
    const response = {
      success: true,
      message: 'Order created successfully',
      orderId: 'ORD_' + Date.now(),
      customerName: data.customerName || 'Guest',
      items: data.items || [],
      total: (data.items || []).reduce((sum, item) => sum + (item.price || 0), 0),
      timestamp: new Date().toISOString()
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
      body: JSON.stringify({ error: error.message })
    };
  }
}
