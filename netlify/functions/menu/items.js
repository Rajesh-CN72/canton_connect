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
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify({
      items: [
        { id: 1, name: 'Dim Sum Platter', price: 25.99, category: 'Appetizer' },
        { id: 2, name: 'Spring Rolls', price: 8.99, category: 'Appetizer' },
        { id: 3, name: 'Sweet and Sour Chicken', price: 15.99, category: 'Main Course' }
      ]
    })
  };
};

