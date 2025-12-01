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
  
  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({
      success: true,
      subscription: {
        planId: "basic",
        status: "active",
        expiryDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
        canAddMoreItems: true,
        remainingItems: 3,
        maxItems: 5,
      },
    }),
  };
};
