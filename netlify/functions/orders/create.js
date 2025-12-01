exports.handler = async (event, context) => {
  try {
    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS'
      },
  try {
    if (event.httpMethod !== "POST") {
      return {
        statusCode: 405,
        body: JSON.stringify({ error: "Method Not Allowed" })
      };
    }

    const data = JSON.parse(event.body || "{}");
    
    // Calculate total
    const total = data.items ? 
      data.items.reduce((sum, item) => sum + (item.price || 0), 0) : 0;
    
    // Create order with timestamp
    const order = {
      id: Date.now().toString(),
      customerName: data.customerName || "Guest",
      items: data.items || [],
      total: total,
      status: "pending",
      createdAt: new Date().toISOString()
    };

    return {
      statusCode: 201,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
      body: JSON.stringify({
        success: true,
        order: order,
        message: "Order created successfully"
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};

