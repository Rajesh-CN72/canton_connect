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
  
  const plans = [
    {
      id: "basic",
      name: "Basic",
      description: "Perfect for home cooks starting out",
      price: 9.99,
      maxMenuItems: 5,
      features: [
        "Up to 5 menu items",
        "Basic analytics",
        "Customer reviews",
      ],
      isPopular: false,
    },
    {
      id: "professional",
      name: "Professional",
      description: "For serious home cooks",
      price: 19.99,
      maxMenuItems: 20,
      features: [
        "Up to 20 menu items",
        "Advanced analytics",
        "Priority listing",
        "Custom branding",
      ],
      isPopular: true,
    },
    {
      id: "enterprise",
      name: "Enterprise",
      description: "For established food businesses",
      price: 39.99,
      maxMenuItems: 100,
      features: [
        "Up to 100 menu items",
        "Full analytics suite",
        "Featured placement",
        "Dedicated support",
        "Custom domain",
      ],
      isPopular: false,
    },
  ];
  
  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({ plans }),
  };
};

