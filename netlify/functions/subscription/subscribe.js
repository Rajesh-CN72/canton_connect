exports.handler = async (event, context) => {
  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
  };
  
  if (event.httpMethod === "OPTIONS") {
    return { statusCode: 200, headers, body: "" };
  }
  
  if (event.httpMethod !== "POST") {
    return { statusCode: 405, headers, body: "Method Not Allowed" };
  }
  
  return {
    statusCode: 200,
    headers,
    body: JSON.stringify({
      success: true,
      message: "Subscription successful (demo mode)",
      subscription: {
        planId: "basic",
        expiryDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
        status: "active",
      },
    }),
  };
};
