exports.handler = async (event, context) => {
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
  };
  
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 200, headers, body: "" };
  }
  
  const demoMenuItems = [
    {
      id: "item-1",
      name: "Dim Sum Platter",
      description: "Assorted steamed dumplings and buns",
      price: 25.99,
      category: "appetizer",
      available: true,
    },
    {
      id: "item-2",
      name: "Kung Pao Chicken",
      description: "Spicy stir-fried chicken with peanuts",
      price: 18.99,
      category: "main",
      available: true,
    },
    {
      id: "item-3",
      name: "Sweet and Sour Pork",
      description: "Crispy pork in tangy sauce",
      price: 19.99,
      category: "main",
      available: true,
    },
  ];
  
  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({
      success: true,
      items: demoMenuItems,
      total: demoMenuItems.length,
    }),
  };
};
