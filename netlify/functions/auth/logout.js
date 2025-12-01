exports.handler = async (event, context) => {
  return {
    statusCode: 200,
    headers: { "Access-Control-Allow-Origin": "*" },
    body: JSON.stringify({ success: true, message: "Logged out" }),
  };
};
