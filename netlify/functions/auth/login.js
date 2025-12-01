exports.handler = async (event, context) => {
  try {
    if (event.httpMethod !== "POST") {
      return {
        statusCode: 405,
        body: JSON.stringify({ error: "Method Not Allowed" })
      };
    }

    const { email, password } = JSON.parse(event.body || "{}");
    
    // Demo authentication
    if (email === "admin@example.com" && password === "admin123") {
      return {
        statusCode: 200,
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          success: true,
          token: "demo-jwt-token-12345",
          user: {
            id: "1",
            email: email,
            name: "Admin User",
            role: "admin"
          }
        })
      };
    }
    
    return {
      statusCode: 401,
      body: JSON.stringify({
        success: false,
        message: "Invalid email or password"
      })
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message })
    };
  }
};
