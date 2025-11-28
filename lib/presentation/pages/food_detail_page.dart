import 'package:flutter/material.dart';
import 'package:canton_connect/data/models/food_item.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/presentation/widgets/food_detail/food_detail_customization.dart';
// REMOVED: unused import
import 'package:canton_connect/presentation/widgets/food_detail/food_detail_action_bar.dart';

class FoodDetailPage extends StatefulWidget {
  final FoodItem foodItem;

  const FoodDetailPage({
    super.key,
    required this.foodItem,
  });

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  late String _currentLanguage;
  bool _isFavorite = false;
  final List<AddOn> _selectedAddOns = [];
  int _quantity = 1;
  final ScrollController _scrollController = ScrollController();
  final PageController _imagePageController = PageController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentLanguage = 'en';
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _handleQuantityChange(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  void _handleAddOnsChanged(List<AddOn> addOns) {
    setState(() {
      _selectedAddOns.clear();
      _selectedAddOns.addAll(addOns);
    });
  }

  void _toggleAddOn(AddOn addOn) {
    setState(() {
      if (_selectedAddOns.contains(addOn)) {
        _selectedAddOns.remove(addOn);
      } else {
        _selectedAddOns.add(addOn);
      }
    });
  }

  void _handleAddToCart() {
    final totalPrice = _calculateTotalPrice();
    final addOnsText = _selectedAddOns.isNotEmpty 
        ? ' with ${_selectedAddOns.length} add-on(s)' 
        : '';
    
    print('Added to cart: ${widget.foodItem.nameEn}');
    print('Quantity: $_quantity');
    print('Add-ons: ${_selectedAddOns.map((a) => a.nameEn).toList()}');
    print('Total: ¥$totalPrice');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart - ${widget.foodItem.nameEn}$addOnsText'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _handleBuyNow() {
    _handleAddToCart();
  }

  double _calculateTotalPrice() {
    double addOnsPrice = _selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price);
    return (widget.foodItem.price + addOnsPrice) * _quantity;
  }

  // REMOVED: unused method _getNutritionValue

  List<String> _getFoodImages() {
    if (widget.foodItem.images.isNotEmpty) {
      return widget.foodItem.images;
    }
    
    return [
      'assets/images/food_placeholder.png',
      'assets/images/food_placeholder_2.png',
      'assets/images/food_placeholder_3.png',
    ];
  }

  String _getAddOnImageUrl(AddOn addOn) {
    return 'assets/images/addon_placeholder.png';
  }

  Widget _buildFoodImage(String imageUrl, BuildContext context) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _buildAssetPlaceholder();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder();
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return _buildAssetPlaceholder();
        },
      );
    }
  }

  Widget _buildAssetPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.fastfood,
        size: 60,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  double _getImageHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return screenHeight * 0.45;
    } else if (screenWidth < 1200) {
      return screenHeight * 0.50;
    } else {
      return screenHeight * 0.60;
    }
  }

  EdgeInsets _getContentPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return const EdgeInsets.all(16);
    } else if (screenWidth < 1200) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 20);
    } else {
      return const EdgeInsets.symmetric(horizontal: 64, vertical: 24);
    }
  }

  double _getTitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    if (screenWidth < 600) {
      return 24;
    } else if (screenWidth < 1200) {
      return 28;
    } else {
      return 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> foodImages = _getFoodImages();
    final double imageHeight = _getImageHeight(context);
    final EdgeInsets contentPadding = _getContentPadding(context);
    final double titleFontSize = _getTitleFontSize(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: imageHeight,
            flexibleSpace: Stack(
              children: [
                PageView.builder(
                  controller: _imagePageController,
                  itemCount: foodImages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildFoodImage(foodImages[index], context);
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withAlpha(102),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(178),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(178),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: _toggleFavorite,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(178),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.share, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (foodImages.length > 1)
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        foodImages.length,
                        (index) => Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.white
                                : Colors.white.withAlpha(178),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(76),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: contentPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _currentLanguage == 'zh'
                                    ? widget.foodItem.nameZh
                                    : widget.foodItem.nameEn,
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '¥${widget.foodItem.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: titleFontSize * 0.9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentLanguage == 'zh'
                              ? widget.foodItem.descriptionZh
                              : widget.foodItem.descriptionEn,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 22,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.foodItem.rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '(${widget.foodItem.reviewCount})',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 24),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: AppColors.textSecondary,
                                  size: 22,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${widget.foodItem.cookingTime} min',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // FIXED: Added missing required parameter
                  Padding(
                    padding: contentPadding.copyWith(top: 0, bottom: 16),
                    child: FoodDetailCustomization(
                      foodItem: widget.foodItem,
                      currentLanguage: _currentLanguage,
                      selectedAddOns: _selectedAddOns,
                      onAddOnsChanged: _handleAddOnsChanged,
                      onAddOnToggled: _toggleAddOn, // Added missing parameter
                    ),
                  ),
                  // FIXED: Simplified add-ons section to avoid syntax errors
                  if (widget.foodItem.addOns.isNotEmpty)
                    Padding(
                      padding: contentPadding.copyWith(top: 0, bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 25),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Add-Ons',
                              style: TextStyle(
                                fontSize: titleFontSize * 0.75,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              children: widget.foodItem.addOns.map((addOn) {
                                final isSelected = _selectedAddOns.contains(addOn);
                                return GestureDetector(
                                  onTap: () => _toggleAddOn(addOn),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? AppColors.primary.withAlpha(40) 
                                          : AppColors.background,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected 
                                            ? AppColors.primary 
                                            : Colors.grey.withAlpha(76),
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected ? AppColors.primary : Colors.transparent,
                                            border: Border.all(
                                              color: isSelected ? AppColors.primary : Colors.grey,
                                              width: 2,
                                            ),
                                          ),
                                          child: isSelected
                                              ? const Icon(Icons.check, size: 18, color: Colors.white)
                                              : null,
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                              image: AssetImage(_getAddOnImageUrl(addOn)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _currentLanguage == 'zh'
                                                    ? addOn.nameZh
                                                    : addOn.nameEn,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                _currentLanguage == 'zh'
                                                    ? addOn.descriptionZh
                                                    : addOn.descriptionEn,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.textSecondary,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          '+¥${addOn.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // FIXED: Simplified drinks section
                  _buildSimplifiedDrinksSection(contentPadding),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: FoodDetailActionBar(
        quantity: _quantity,
        totalPrice: _calculateTotalPrice(),
        onQuantityChanged: _handleQuantityChange,
        onAddToCart: _handleAddToCart,
        onBuyNow: _handleBuyNow,
      ),
    );
  }

  // FIXED: Simplified drinks section
  Widget _buildSimplifiedDrinksSection(EdgeInsets contentPadding) {
    return Padding(
      padding: contentPadding.copyWith(top: 0, bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 25),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended Drinks',
                  style: TextStyle(
                    fontSize: _getTitleFontSize(context) * 0.75,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('See all drinks tapped');
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                    child: const Icon(Icons.local_drink, size: 40, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Iced Lemon Tea',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Refreshing iced tea with lemon',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '¥8.00',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          print('Add drink to cart');
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
