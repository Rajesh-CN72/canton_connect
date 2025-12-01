exports.handler = async (event, context) => {
  return {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
    body: JSON.stringify({
      message: "Netlify Functions are working!",
      path: event.path,
      method: event.httpMethod,
      time: new Date().toISOString()
    })
  };
};
