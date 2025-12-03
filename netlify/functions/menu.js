exports.handler = async function(event, context) {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify({
      items: [
        { id: 1, name: 'Dim Sum Platter', price: 25.99, category: 'Appetizer', description: 'Assorted steamed dumplings' },
        { id: 2, name: 'Spring Rolls', price: 8.99, category: 'Appetizer', description: 'Crispy vegetable rolls' },
        { id: 3, name: 'Kung Pao Chicken', price: 18.99, category: 'Main Course', description: 'Spicy chicken with peanuts' },
        { id: 4, name: 'Yangzhou Fried Rice', price: 14.99, category: 'Main Course', description: 'Special fried rice with shrimp and vegetables' },
        { id: 5, name: 'Sweet and Sour Pork', price: 16.99, category: 'Main Course', description: 'Crispy pork in tangy sauce' }
      ]
    })
  };
}
