exports.handler = async (event, context) => {
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
  };
  
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 200, headers, body: "" };
  }
  
  if (event.httpMethod !== "GET") {
    return { statusCode: 405, headers, body: "Method Not Allowed" };
  }
  
  const demoOrders = [
    {
      id: "demo-order-1",
      orderId: "ORD001",
      customerName: "John Doe",
      customerPhone: "123-456-7890",
      items: [{ name: "Dim Sum Platter", quantity: 2, price: 25.99 }],
      totalAmount: 51.98,
      status: "delivered",
      orderDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      id: "demo-order-2",
      orderId: "ORD002",
      customerName: "Jane Smith",
      customerPhone: "987-654-3210",
      items: [{ name: "Kung Pao Chicken", quantity: 1, price: 18.99 }],
      totalAmount: 18.99,
      status: "preparing",
      orderDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
    },
  ];
  
  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({
      success: true,
      orders: demoOrders,
      total: demoOrders.length,
    }),
  };
};
