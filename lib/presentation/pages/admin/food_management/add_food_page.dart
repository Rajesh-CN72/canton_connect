import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  State<AddFoodPage> createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  
  // Form controllers
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _caloriesController = TextEditingController();
  
  // Form values
  String _selectedCategory = 'Main Course';
  final List<String> _selectedTags = [];
  bool _isVegetarian = false;
  bool _isVegan = false;
  bool _isSpicy = false;
  bool _isAvailable = true;
  bool _isFeatured = false; // ADDED: Featured field
  bool _isLoading = false;

  // Image picker
  XFile? _selectedImage;
  File? _imageFile;

  // Available categories and tags - MARKED AS USED
  final List<String> _categories = [
    'Main Course',
    'Appetizers',
    'Desserts',
    'Beverages',
    'Salads',
    'Soups',
    'Specials',
    'Family Packages',
    'Signature Dishes',
    'Youth Favorites',
    'Healthy Options',
  ];

  final List<String> _availableTags = [
    'Popular',
    'Chef Special',
    'Healthy',
    'Gluten Free',
    'Dairy Free',
    'Low Carb',
    'High Protein'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _prepTimeController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  // Image Picker Methods - FIXED: Removed unused _showImageSourceDialog
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = image;
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Future<void> _takePhotoWithCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = image;
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      _showError('Failed to take photo: $e');
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _imageFile = null;
    });
  }

  // FIXED: Removed unused _showImageSourceDialog method

  // FIXED: _toggleTag is now used in tags section
  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  // FIXED: _submitForm is now used by submit button
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      _showError('Please fill all required fields correctly');
      return;
    }

    // Optional: Require image
    if (_selectedImage == null) {
      final shouldContinue = await _showImageRequiredDialog();
      if (!shouldContinue) {
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Create food data
      final foodData = {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'prepTime': int.parse(_prepTimeController.text),
        'calories': _caloriesController.text.isNotEmpty ? int.parse(_caloriesController.text) : null,
        'tags': _selectedTags,
        'isVegetarian': _isVegetarian,
        'isVegan': _isVegan,
        'isSpicy': _isSpicy,
        'isAvailable': _isAvailable,
        'isFeatured': _isFeatured, // ADDED: Featured field
        'imagePath': _selectedImage?.path,
      };

      print('Food item created: $foodData');
      print('Image path: ${_selectedImage?.path}');
      
      _showSuccess('Food item added successfully!');
      _resetForm();
      
    } catch (e) {
      _showError('Failed to add food item: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<bool> _showImageRequiredDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No Image Selected'),
          content: const Text('Would you like to continue without an image?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Add Image'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Continue Anyway'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _prepTimeController.clear();
    _caloriesController.clear();
    setState(() {
      _selectedCategory = 'Main Course';
      _selectedTags.clear();
      _isVegetarian = false;
      _isVegan = false;
      _isSpicy = false;
      _isAvailable = true;
      _isFeatured = false; // ADDED: Reset featured field
      _selectedImage = null;
      _imageFile = null;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFE74C3C),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF27AE60),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Add Food Item'),
        backgroundColor: const Color(0xFF27AE60),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _resetForm,
            tooltip: 'Clear Form',
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingState()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Upload Section
                    _buildImageUploadSection(),
                    const SizedBox(height: 24),
                    
                    // Basic Information Section
                    _buildBasicInfoSection(),
                    const SizedBox(height: 24),
                    
                    // Category & Dietary Section
                    _buildCategoryDietarySection(),
                    const SizedBox(height: 24),
                    
                    // Tags Section
                    _buildTagsSection(),
                    const SizedBox(height: 24),
                    
                    // Featured & Availability Section
                    _buildFeaturedAvailabilitySection(),
                    const SizedBox(height: 32),
                    
                    // Submit Button
                    _buildSubmitButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF27AE60)),
          ),
          SizedBox(height: 16),
          Text(
            'Adding Food Item...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEAEDF0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Food Image',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),
            _selectedImage != null
                ? _buildSelectedImage()
                : const _ImagePlaceholder(),
            const SizedBox(height: 12),
            _buildImagePickerButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImage() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEAEDF0)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF8F9FA),
                      child: const Icon(
                        Icons.error_outline,
                        size: 40,
                        color: Color(0xFFE74C3C),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: _removeImage,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _selectedImage!.name,
          style: const TextStyle(
            color: Color(0xFF566573),
            fontSize: 12,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildImagePickerButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _pickImageFromGallery,
            icon: const Icon(Icons.photo_library, size: 20),
            label: const Text('Gallery'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2C3E50),
              side: const BorderSide(color: Color(0xFFEAEDF0)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takePhotoWithCamera,
            icon: const Icon(Icons.camera_alt, size: 20),
            label: const Text('Camera'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2C3E50),
              side: const BorderSide(color: Color(0xFFEAEDF0)),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEAEDF0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 16),
            
            // Name Field
            _buildTextField(
              controller: _nameController,
              label: 'Food Name *',
              hintText: 'Enter food name',
              prefixIcon: Icons.fastfood,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter food name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Description Field
            _buildTextArea(
              controller: _descriptionController,
              label: 'Description *',
              hintText: 'Describe the food item...',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                if (value.length < 10) {
                  return 'Description should be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Price and Prep Time Row
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _priceController,
                    label: 'Price (\¥) *',
                    hintText: '0.00',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter valid price';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _prepTimeController,
                    label: 'Prep Time (mins) *',
                    hintText: '30',
                    prefixIcon: Icons.timer,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter prep time';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter valid time';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Calories Field
            _buildTextField(
              controller: _caloriesController,
              label: 'Calories (optional)',
              hintText: 'Enter calories',
              prefixIcon: Icons.local_fire_department,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDietarySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEAEDF0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category & Dietary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 16),
            
            // Category Dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category *',
                  style: TextStyle(
                    color: Color(0xFF2C3E50),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFEAEDF0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF566573)),
                      items: _categories.map((String category) {
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
            ),
            const SizedBox(height: 16),
            
            // Dietary Options
            const Text(
              'Dietary Information',
              style: TextStyle(
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildDietaryChip(
                  label: 'Vegetarian',
                  value: _isVegetarian,
                  onChanged: (value) => setState(() => _isVegetarian = value!),
                  activeColor: const Color(0xFF27AE60),
                ),
                _buildDietaryChip(
                  label: 'Vegan',
                  value: _isVegan,
                  onChanged: (value) => setState(() => _isVegan = value!),
                  activeColor: const Color(0xFF229954),
                ),
                _buildDietaryChip(
                  label: 'Spicy',
                  value: _isSpicy,
                  onChanged: (value) => setState(() => _isSpicy = value!),
                  activeColor: const Color(0xFFE74C3C),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEAEDF0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tags & Labels',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select relevant tags for your food item',
              style: TextStyle(
                color: Color(0xFF566573),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableTags.map((tag) {
                final isSelected = _selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) => _toggleTag(tag), // FIXED: Now using _toggleTag
                  selectedColor: const Color(0xFFD5F4E2),
                  checkmarkColor: const Color(0xFF27AE60),
                  labelStyle: TextStyle(
                    color: isSelected ? const Color(0xFF27AE60) : const Color(0xFF2C3E50),
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ADDED: New section for Featured & Availability
  Widget _buildFeaturedAvailabilitySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFEAEDF0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Featured Item Toggle
            Row(
              children: [
                const Icon(
                  Icons.star_outlined,
                  color: Color(0xFFFFD700),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Item',
                        style: TextStyle(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Show this item in featured section on menu',
                        style: TextStyle(
                          color: Color(0xFF566573),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isFeatured,
                  onChanged: (value) => setState(() => _isFeatured = value),
                  activeThumbColor: const Color(0xFFFFD700),
                  activeTrackColor: const Color(0xFFFFF176),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFEAEDF0)),
            const SizedBox(height: 16),
            // Availability Toggle
            Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  color: Color(0xFF2C3E50),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available for Order',
                        style: TextStyle(
                          color: Color(0xFF2C3E50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Make this item available for customers to order',
                        style: TextStyle(
                          color: Color(0xFF566573),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isAvailable,
                  onChanged: (value) => setState(() => _isAvailable = value),
                  activeThumbColor: const Color(0xFF27AE60),
                  activeTrackColor: const Color(0xFFA8E6A3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm, // FIXED: Now using _submitForm
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF27AE60),
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Text(
                'Add Food Item',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  // FIXED: _buildTextField is now used in basic info section
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: const Color(0xFF566573)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFEAEDF0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFEAEDF0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFF27AE60)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  // FIXED: _buildTextArea is now used in basic info section
  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required int maxLines,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            hintText: 'Describe the food item...',
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFEAEDF0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFFEAEDF0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Color(0xFF27AE60)),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  // FIXED: _buildDietaryChip is now used in category dietary section
  Widget _buildDietaryChip({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required Color activeColor,
  }) {
    Color backgroundColor;
    // FIXED: Replace .value with .toARGB32()
    switch (activeColor.toARGB32()) {
      case 0xFF27AE60: // Green
        backgroundColor = const Color(0xFFD5F4E2);
        break;
      case 0xFF229954: // Dark Green
        backgroundColor = const Color(0xFFA8E6A3);
        break;
      case 0xFFE74C3C: // Red
        backgroundColor = const Color(0xFFFADBD8);
        break;
      default:
        backgroundColor = const Color(0xFFEAEDF0);
    }

    // FIXED: Added required label and onSelected parameters
    return FilterChip(
      label: Text(label),
      selected: value,
      onSelected: onChanged,
      selectedColor: backgroundColor,
      checkmarkColor: activeColor,
      labelStyle: TextStyle(
        color: value ? activeColor : const Color(0xFF2C3E50),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFEAEDF0)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fastfood_outlined,
                size: 40,
                color: Color(0xFF566573),
              ),
              SizedBox(height: 8),
              Text(
                'Tap buttons below to add image',
                style: TextStyle(
                  color: Color(0xFF566573),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gallery or Camera',
                style: TextStyle(
                  color: Color(0xFF566573),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
