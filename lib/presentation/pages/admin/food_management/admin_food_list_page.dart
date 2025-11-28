// D:\FlutterProjects\Home_Cook\canton_connect\lib\presentation\pages\admin\food_management\food_list_page.dart
import 'package:flutter/material.dart';

// Define the models locally since they're not available through imports
class FoodItem {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final int cookingTime;
  final bool isSpicy;
  final bool isVegetarian;
  final bool isVegan;
  final List<String> ingredients;
  final List<String> allergens;
  final NutritionInfo nutritionInfo;
  final List<AddOn> addOns;
  final String category;
  final String subCategory;
  final bool isPopular;
  final bool isNew;
  final int serves;

  const FoodItem({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.cookingTime,
    required this.isSpicy,
    required this.isVegetarian,
    required this.isVegan,
    required this.ingredients,
    required this.allergens,
    required this.nutritionInfo,
    required this.addOns,
    required this.category,
    required this.subCategory,
    required this.isPopular,
    required this.isNew,
    required this.serves,
  });

  // Copy with method for editing
  FoodItem copyWith({
    String? id,
    String? nameEn,
    String? nameZh,
    String? descriptionEn,
    String? descriptionZh,
    double? price,
    List<String>? images,
    double? rating,
    int? reviewCount,
    int? cookingTime,
    bool? isSpicy,
    bool? isVegetarian,
    bool? isVegan,
    List<String>? ingredients,
    List<String>? allergens,
    NutritionInfo? nutritionInfo,
    List<AddOn>? addOns,
    String? category,
    String? subCategory,
    bool? isPopular,
    bool? isNew,
    int? serves,
  }) {
    return FoodItem(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameZh: nameZh ?? this.nameZh,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      price: price ?? this.price,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      cookingTime: cookingTime ?? this.cookingTime,
      isSpicy: isSpicy ?? this.isSpicy,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isVegan: isVegan ?? this.isVegan,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      addOns: addOns ?? this.addOns,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      isPopular: isPopular ?? this.isPopular,
      isNew: isNew ?? this.isNew,
      serves: serves ?? this.serves,
    );
  }
}

class NutritionInfo {
  final int? calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sugar;
  final int sodium;

  const NutritionInfo({
    this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sugar,
    required this.sodium,
  });

  NutritionInfo copyWith({
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    double? fiber,
    double? sugar,
    int? sodium,
  }) {
    return NutritionInfo(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sugar: sugar ?? this.sugar,
      sodium: sodium ?? this.sodium,
    );
  }
}

class AddOn {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final bool isAvailable;

  const AddOn({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.isAvailable,
  });
}

// Sample data - you can replace this with your actual MenuData
class LocalMenuData {
  static List<FoodItem> get sampleFoodItems => [
    const FoodItem(
      id: '1',
      nameEn: 'Spring Rolls',
      nameZh: '春卷',
      descriptionEn: 'Crispy fried spring rolls filled with vegetables',
      descriptionZh: '酥脆炸春卷，内馅蔬菜',
      price: 8.99,
      images: ['assets/images/foods/appetizers/spring_rolls.jpg'],
      rating: 4.3,
      reviewCount: 89,
      cookingTime: 15,
      isSpicy: false,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Carrots', 'Cabbage', 'Mushrooms'],
      allergens: ['Wheat'],
      nutritionInfo: NutritionInfo(
        calories: 180,
        protein: 4,
        carbs: 25,
        fat: 7,
        fiber: 2,
        sugar: 3,
        sodium: 320,
      ),
      addOns: [
        AddOn(
          id: 'addon_1',
          nameEn: 'Extra Sauce',
          nameZh: '额外酱料',
          descriptionEn: 'Additional sweet and sour sauce',
          descriptionZh: '额外甜酸酱',
          price: 0.50,
          isAvailable: true,
        ),
      ],
      category: 'Appetizers',
      subCategory: 'Vegetarian',
      isPopular: false,
      isNew: false,
      serves: 2,
    ),
    const FoodItem(
      id: '2',
      nameEn: 'Kung Pao Chicken',
      nameZh: '宫保鸡丁',
      descriptionEn: 'Spicy stir-fried chicken with peanuts',
      descriptionZh: '香辣可口的宫保鸡丁，配以花生',
      price: 18.99,
      images: ['assets/images/foods/main_course/kung_pao_chicken.jpg'],
      rating: 4.5,
      reviewCount: 128,
      cookingTime: 20,
      isSpicy: true,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Chicken Breast', 'Peanuts', 'Bell Peppers'],
      allergens: ['Peanuts', 'Soy'],
      nutritionInfo: NutritionInfo(
        calories: 320,
        protein: 25,
        carbs: 12,
        fat: 18,
        fiber: 3,
        sugar: 6,
        sodium: 890,
      ),
      addOns: [],
      category: 'Main Courses',
      subCategory: 'Chicken',
      isPopular: true,
      isNew: false,
      serves: 2,
    ),
    const FoodItem(
      id: '3',
      nameEn: 'Beef with Broccoli',
      nameZh: '西兰花牛肉',
      descriptionEn: 'Tender beef slices with fresh broccoli',
      descriptionZh: '嫩牛肉片与新鲜西兰花炒制',
      price: 19.99,
      images: ['assets/images/foods/main_course/beef_broccoli.jpg'],
      rating: 4.6,
      reviewCount: 112,
      cookingTime: 22,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Beef Sirloin', 'Broccoli', 'Garlic'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 290,
        protein: 28,
        carbs: 8,
        fat: 16,
        fiber: 3,
        sugar: 4,
        sodium: 780,
      ),
      addOns: [],
      category: 'Main Courses',
      subCategory: 'Beef',
      isPopular: true,
      isNew: false,
      serves: 2,
    ),
  ];

  static List<String> get categories => [
    'All',
    'Family Packages',
    'Signature Dishes',
    'Youth Favorites', 
    'Healthy Options',
    'Desserts',
    'Appetizers',
    'Main Courses',
    'Soups',
    'Drinks',
  ];
}

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  // Define colors
  static const Color primaryColor = Color(0xFF27AE60);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF566573);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF27AE60);
  static const Color borderLight = Color(0xFFEAEDF0);
  static const Color shadowLight = Color(0x1A000000);

  List<FoodItem> _foodItems = [];
  List<FoodItem> _filteredFoodItems = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFoodItems();
  }

  void _loadFoodItems() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading from database/API
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _foodItems = LocalMenuData.sampleFoodItems;
        _filteredFoodItems = _foodItems;
        _isLoading = false;
      });
    });
  }

  void _filterFoodItems() {
    setState(() {
      _filteredFoodItems = _foodItems.where((item) {
        final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
        final matchesSearch = _searchQuery.isEmpty ||
            item.nameEn.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.nameZh.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            item.descriptionEn.toLowerCase().contains(_searchQuery.toLowerCase());
        
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _showAddFoodDialog() {
    showDialog(
      context: context,
      builder: (context) => _FoodItemDialog(
        onSave: _addFoodItem,
      ),
    );
  }

  void _showEditFoodDialog(FoodItem foodItem) {
    showDialog(
      context: context,
      builder: (context) => _FoodItemDialog(
        foodItem: foodItem,
        onSave: _updateFoodItem,
      ),
    );
  }

  void _showDeleteConfirmation(FoodItem foodItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Food Item'),
        content: Text('Are you sure you want to delete "${foodItem.nameEn}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteFoodItem(foodItem);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _addFoodItem(FoodItem newItem) {
    setState(() {
      _foodItems.insert(0, newItem);
      _filterFoodItems();
    });
    _showSnackBar('Food item added successfully!', success);
  }

  void _updateFoodItem(FoodItem updatedItem) {
    setState(() {
      final index = _foodItems.indexWhere((item) => item.id == updatedItem.id);
      if (index != -1) {
        _foodItems[index] = updatedItem;
        _filterFoodItems();
      }
    });
    _showSnackBar('Food item updated successfully!', success);
  }

  void _deleteFoodItem(FoodItem foodItem) {
    setState(() {
      _foodItems.removeWhere((item) => item.id == foodItem.id);
      _filterFoodItems();
    });
    _showSnackBar('Food item deleted successfully!', success);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleAvailability(FoodItem foodItem) {
    _showSnackBar(
      'Availability toggled for ${foodItem.nameEn}',
      primaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Food Management'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFoodItems,
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFoodDialog,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          _buildSearchFilterSection(),
          
          // Food Items List
          Expanded(
            child: _isLoading
                ? _buildLoadingState()
                : _filteredFoodItems.isEmpty
                    ? _buildEmptyState()
                    : _buildFoodList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: surface,
        boxShadow: [
          BoxShadow(
            color: shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search food items...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: borderLight),
              ),
              filled: true,
              fillColor: background,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
                _filterFoodItems();
              });
            },
          ),
          const SizedBox(height: 12),
          
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: LocalMenuData.categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'All';
                        _filterFoodItems();
                      });
                    },
                    selectedColor: primaryColor.withOpacity(0.2),
                    checkmarkColor: primaryColor,
                    labelStyle: TextStyle(
                      color: isSelected ? primaryColor : textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: 16),
          Text(
            'Loading food items...',
            style: TextStyle(
              color: textPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.fastfood_outlined,
            size: 64,
            color: textSecondary,
          ),
          const SizedBox(height: 16),
          const Text(
            'No food items found',
            style: TextStyle(
              color: textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedCategory != 'All'
                ? 'Try changing the category filter or search query'
                : 'Add your first food item using the + button',
            style: const TextStyle(
              color: textSecondary,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredFoodItems.length,
      itemBuilder: (context, index) {
        final foodItem = _filteredFoodItems[index];
        return _buildFoodItemCard(foodItem);
      },
    );
  }

  Widget _buildFoodItemCard(FoodItem foodItem) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: background,
                image: const DecorationImage(
                  image: AssetImage('assets/images/menu/placeholder_food.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Price
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              foodItem.nameEn,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                            Text(
                              foodItem.nameZh,
                              style: const TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Category and Dietary Info
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      _buildInfoChip(foodItem.category, primaryColor),
                      if (foodItem.isVegetarian)
                        _buildInfoChip('Vegetarian', const Color(0xFF27AE60)),
                      if (foodItem.isVegan)
                        _buildInfoChip('Vegan', const Color(0xFF229954)),
                      if (foodItem.isSpicy)
                        _buildInfoChip('Spicy', const Color(0xFFE74C3C)),
                      if (foodItem.isPopular)
                        _buildInfoChip('Popular', const Color(0xFFF39C12)),
                      if (foodItem.isNew)
                        _buildInfoChip('New', const Color(0xFF3498DB)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Description
                  Text(
                    foodItem.descriptionEn,
                    style: const TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Action Buttons
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditFoodDialog(foodItem);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(foodItem);
                    break;
                  case 'toggle_availability':
                    _toggleAvailability(foodItem);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'toggle_availability',
                  child: Row(
                    children: [
                      Icon(Icons.inventory_2, size: 20),
                      SizedBox(width: 8),
                      Text('Toggle Availability'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20, color: error),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(color: error),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _FoodItemDialog extends StatefulWidget {
  final FoodItem? foodItem;
  final Function(FoodItem) onSave;

  const _FoodItemDialog({
    this.foodItem,
    required this.onSave,
  });

  @override
  State<_FoodItemDialog> createState() => _FoodItemDialogState();
}

class _FoodItemDialogState extends State<_FoodItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameEnController = TextEditingController();
  final _nameZhController = TextEditingController();
  final _descriptionEnController = TextEditingController();
  final _descriptionZhController = TextEditingController();
  final _priceController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _caloriesController = TextEditingController();

  String _selectedCategory = 'Main Courses';
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isSpicy = false;
  bool _isPopular = false;
  bool _isNew = false;
  bool _isAvailable = true;

  @override
  void initState() {
    super.initState();
    if (widget.foodItem != null) {
      _initializeForm(widget.foodItem!);
    }
  }

  void _initializeForm(FoodItem foodItem) {
    _nameEnController.text = foodItem.nameEn;
    _nameZhController.text = foodItem.nameZh;
    _descriptionEnController.text = foodItem.descriptionEn;
    _descriptionZhController.text = foodItem.descriptionZh;
    _priceController.text = foodItem.price.toStringAsFixed(2);
    _prepTimeController.text = foodItem.cookingTime.toString();
    _caloriesController.text = foodItem.nutritionInfo.calories?.toString() ?? '';
    _selectedCategory = foodItem.category;
    _isVegetarian = foodItem.isVegetarian;
    _isVegan = foodItem.isVegan;
    _isSpicy = foodItem.isSpicy;
    _isPopular = foodItem.isPopular;
    _isNew = foodItem.isNew;
    _isAvailable = true;
  }

  void _saveFoodItem() {
    if (_formKey.currentState!.validate()) {
      final foodItem = FoodItem(
        id: widget.foodItem?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        nameEn: _nameEnController.text.trim(),
        nameZh: _nameZhController.text.trim(),
        descriptionEn: _descriptionEnController.text.trim(),
        descriptionZh: _descriptionZhController.text.trim(),
        price: double.parse(_priceController.text),
        images: widget.foodItem?.images ?? ['assets/images/menu/placeholder_food.jpg'],
        rating: widget.foodItem?.rating ?? 4.0,
        reviewCount: widget.foodItem?.reviewCount ?? 0,
        cookingTime: int.parse(_prepTimeController.text),
        isSpicy: _isSpicy,
        isVegetarian: _isVegetarian,
        isVegan: _isVegan,
        ingredients: widget.foodItem?.ingredients ?? [],
        allergens: widget.foodItem?.allergens ?? [],
        nutritionInfo: NutritionInfo(
          calories: _caloriesController.text.isNotEmpty ? int.parse(_caloriesController.text) : null,
          protein: widget.foodItem?.nutritionInfo.protein ?? 0,
          carbs: widget.foodItem?.nutritionInfo.carbs ?? 0,
          fat: widget.foodItem?.nutritionInfo.fat ?? 0,
          fiber: widget.foodItem?.nutritionInfo.fiber ?? 0,
          sugar: widget.foodItem?.nutritionInfo.sugar ?? 0,
          sodium: widget.foodItem?.nutritionInfo.sodium ?? 0,
        ),
        addOns: widget.foodItem?.addOns ?? [],
        category: _selectedCategory,
        subCategory: widget.foodItem?.subCategory ?? 'General',
        isPopular: _isPopular,
        isNew: _isNew,
        serves: widget.foodItem?.serves ?? 2,
      );

      widget.onSave(foodItem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.foodItem == null ? 'Add Food Item' : 'Edit Food Item',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              
              // Basic Information
              _buildTextField(
                controller: _nameEnController,
                label: 'English Name *',
                hintText: 'Enter food name in English',
              ),
              const SizedBox(height: 12),
              
              _buildTextField(
                controller: _nameZhController,
                label: 'Chinese Name *',
                hintText: 'Enter food name in Chinese',
              ),
              const SizedBox(height: 12),
              
              _buildTextArea(
                controller: _descriptionEnController,
                label: 'English Description *',
                hintText: 'Enter description in English',
              ),
              const SizedBox(height: 12),
              
              _buildTextArea(
                controller: _descriptionZhController,
                label: 'Chinese Description *',
                hintText: 'Enter description in Chinese',
              ),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _priceController,
                      label: 'Price (\$) *',
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: _prepTimeController,
                      label: 'Prep Time (mins) *',
                      hintText: '15',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              _buildTextField(
                controller: _caloriesController,
                label: 'Calories (optional)',
                hintText: 'Enter calories',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              
              // Category Dropdown
              _buildCategoryDropdown(),
              const SizedBox(height: 20),
              
              // Dietary Options
              _buildDietaryOptions(),
              const SizedBox(height: 20),
              
              // Status Options
              _buildStatusOptions(),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveFoodItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF27AE60),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            if (keyboardType == TextInputType.number && double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category *',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              items: LocalMenuData.categories.where((cat) => cat != 'All').map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDietaryOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dietary Information',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            _buildToggleOption(
              label: 'Vegetarian',
              value: _isVegetarian,
              onChanged: (value) => setState(() => _isVegetarian = value!),
            ),
            _buildToggleOption(
              label: 'Vegan',
              value: _isVegan,
              onChanged: (value) => setState(() => _isVegan = value!),
            ),
            _buildToggleOption(
              label: 'Spicy',
              value: _isSpicy,
              onChanged: (value) => setState(() => _isSpicy = value!),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            _buildToggleOption(
              label: 'Popular',
              value: _isPopular,
              onChanged: (value) => setState(() => _isPopular = value!),
            ),
            _buildToggleOption(
              label: 'New Item',
              value: _isNew,
              onChanged: (value) => setState(() => _isNew = value!),
            ),
            _buildToggleOption(
              label: 'Available',
              value: _isAvailable,
              onChanged: (value) => setState(() => _isAvailable = value!),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleOption({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: onChanged,
      selectedColor: const Color(0xFF27AE60).withOpacity(0.2),
      checkmarkColor: const Color(0xFF27AE60),
      labelStyle: TextStyle(
        color: value ? const Color(0xFF27AE60) : Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  void dispose() {
    _nameEnController.dispose();
    _nameZhController.dispose();
    _descriptionEnController.dispose();
    _descriptionZhController.dispose();
    _priceController.dispose();
    _prepTimeController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}
