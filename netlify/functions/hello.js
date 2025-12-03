exports.handler = async function(event, context) {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify({
      message: 'Welcome to Canton Connect API!',
      status: 'active',
      timestamp: new Date().toISOString(),
      path: event.path,
      method: event.httpMethod
    })
  };
}
