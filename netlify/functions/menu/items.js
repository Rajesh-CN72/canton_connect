exports.handler = async (event, context) => {
  const menuItems = [
    { id: 1, name: "Dim Sum Platter", price: 25.99, category: "Appetizer" },
    { id: 2, name: "Kung Pao Chicken", price: 18.99, category: "Main Course" },
    { id: 3, name: "Sweet and Sour Pork", price: 19.99, category: "Main Course" },
    { id: 4, name: "Spring Rolls", price: 8.99, category: "Appetizer" },
    { id: 5, name: "Fried Rice", price: 12.99, category: "Side" },
    { id: 6, name: "Hot and Sour Soup", price: 6.99, category: "Soup" }
  ];

  return {
    statusCode: 200,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
    body: JSON.stringify(menuItems)
  };
};
