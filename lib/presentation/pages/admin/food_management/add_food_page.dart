// lib/presentation/pages/admin/food_management/add_food_page.dart

import 'package:flutter/material.dart';
import 'package:canton_connect/data/services/api_service.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  String _selectedCategory = '2'; // Default to Main Course
  String _selectedSubcategory = '1'; // Default to first subcategory
  bool _isAvailable = true;
  bool _isVegetarian = false;
  bool _isSpicy = false;

  // Mock categories and subcategories
  final Map<String, List<String>> _categories = {
    '1': ['vegetarian', 'meat', 'seafood'], // Appetizers
    '2': ['chicken', 'beef', 'pork', 'seafood', 'tofu', 'duck'], // Main Course
    '3': ['pudding', 'cake', 'ice_cream'], // Desserts
    '4': ['tea', 'juice', 'soda', 'alcoholic'], // Drinks
  };

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _addFoodItem() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Create food item data directly without storing in unused variable
      await ApiService().addFoodItem({
        'name': _nameController.text.trim(),
        'name_en': _nameController.text.trim(), // For consistency
        'description': _descriptionController.text.trim(),
        'description_en': _descriptionController.text.trim(), // For consistency
        'price': double.parse(_priceController.text),
        'category_id': _selectedCategory,
        'subcategory_id': _selectedSubcategory,
        'is_available': _isAvailable,
        'is_vegetarian': _isVegetarian,
        'is_spicy': _isSpicy,
        'image_url': _getDefaultImageUrl(),
        'is_popular': false,
        'cooking_time': 15,
        'spice_level': _isSpicy ? 2 : 0,
        'rating': 0.0,
        'review_count': 0,
        'sort_order': 1,
        'created_at': DateTime.now().toIso8601String(),
      });

      setState(() {
        _successMessage = '食品添加成功！';
      });

      // Clear form on success
      _formKey.currentState!.reset();
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      
    } catch (e) {
      setState(() {
        _errorMessage = '添加食品失败: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getDefaultImageUrl() {
    // Return a default image based on category
    switch (_selectedCategory) {
      case '1': // Appetizers
        return 'assets/images/menu/spring_rolls.jpg';
      case '2': // Main Course
        return 'assets/images/menu/kung_pao_chicken.jpg';
      case '3': // Desserts
        return 'assets/images/menu/mango_pudding.jpg';
      case '4': // Drinks
        return 'assets/images/menu/bubble_tea.jpg';
      default:
        return 'assets/images/food_placeholder.png';
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    setState(() {
      _selectedCategory = '2';
      _selectedSubcategory = '1';
      _isAvailable = true;
      _isVegetarian = false;
      _isSpicy = false;
      _errorMessage = null;
      _successMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加新食品'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearForm,
            tooltip: '清除表单',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Success Message
              if (_successMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green[600], size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _successMessage!,
                          style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Error Message
              if (_errorMessage != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Food Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '食品名称',
                  hintText: '输入食品名称',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fastfood),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入食品名称';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '描述',
                  hintText: '输入食品描述',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入描述';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: '价格',
                  hintText: '输入价格',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请输入价格';
                  }
                  if (double.tryParse(value) == null) {
                    return '请输入有效的价格';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory, // Fixed: Replaced deprecated 'value' with 'initialValue'
                decoration: const InputDecoration(
                  labelText: '分类',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.keys.map((String category) {
                  String categoryName = '';
                  switch (category) {
                    case '1': categoryName = '开胃菜'; break;
                    case '2': categoryName = '主菜'; break;
                    case '3': categoryName = '甜品'; break;
                    case '4': categoryName = '饮品'; break;
                  }
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(categoryName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    _selectedSubcategory = _categories[newValue]!.first;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请选择分类';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Subcategory Dropdown
              DropdownButtonFormField<String>(
                initialValue: _selectedSubcategory, // Fixed: Replaced deprecated 'value' with 'initialValue'
                decoration: const InputDecoration(
                  labelText: '子分类',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.list),
                ),
                items: _categories[_selectedCategory]!.map((String subcategory) {
                  return DropdownMenuItem<String>(
                    value: subcategory,
                    child: Text(subcategory),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSubcategory = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '请选择子分类';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Toggle Switches
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '食品属性',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Available
                      SwitchListTile(
                        title: const Text('可供订购'),
                        value: _isAvailable,
                        onChanged: (bool value) {
                          setState(() {
                            _isAvailable = value;
                          });
                        },
                      ),
                      // Vegetarian
                      SwitchListTile(
                        title: const Text('素食'),
                        value: _isVegetarian,
                        onChanged: (bool value) {
                          setState(() {
                            _isVegetarian = value;
                          });
                        },
                      ),
                      // Spicy
                      SwitchListTile(
                        title: const Text('辣味'),
                        value: _isSpicy,
                        onChanged: (bool value) {
                          setState(() {
                            _isSpicy = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Image Preview (using default images)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '图片预览',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Center(
                          child: Text(
                            _getCategoryName(_selectedCategory),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '注意: Web版本使用默认图片。如需实际图片，请实现Web兼容的图片上传功能。',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Add Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _addFoodItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          '添加食品',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case '1': return '默认开胃菜图片';
      case '2': return '默认主菜图片';
      case '3': return '默认甜品图片';
      case '4': return '默认饮品图片';
      default: return '默认食品图片';
    }
  }
}
