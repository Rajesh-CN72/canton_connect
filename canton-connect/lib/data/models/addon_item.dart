class AddOnItem {
  final String id;
  final String nameEn;
  final String nameZh;
  final String descriptionEn;
  final String descriptionZh;
  final double price;
  final String image;

  const AddOnItem({
    required this.id,
    required this.nameEn,
    required this.nameZh,
    required this.descriptionEn,
    required this.descriptionZh,
    required this.price,
    required this.image,
  });

  // Helper method to get name based on language
  String getName(String language) => language == 'zh' ? nameZh : nameEn;

  // Helper method to get description based on language
  String getDescription(String language) => language == 'zh' ? descriptionZh : descriptionEn;

  // Convert to Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameZh': nameZh,
      'descriptionEn': descriptionEn,
      'descriptionZh': descriptionZh,
      'price': price,
      'image': image,
    };
  }

  // Create from Map for JSON deserialization
  factory AddOnItem.fromJson(Map<String, dynamic> json) {
    return AddOnItem(
      id: json['id'] ?? '',
      nameEn: json['nameEn'] ?? '',
      nameZh: json['nameZh'] ?? '',
      descriptionEn: json['descriptionEn'] ?? '',
      descriptionZh: json['descriptionZh'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
    );
  }

  // Copy with method for updates
  AddOnItem copyWith({
    String? id,
    String? nameEn,
    String? nameZh,
    String? descriptionEn,
    String? descriptionZh,
    double? price,
    String? image,
  }) {
    return AddOnItem(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameZh: nameZh ?? this.nameZh,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionZh: descriptionZh ?? this.descriptionZh,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddOnItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AddOnItem(id: $id, nameEn: $nameEn, price: $price)';
  }
}

// Sample data for development
class AddOnData {
  static final List<AddOnItem> sampleAddOns = [
    const AddOnItem(
      id: 'addon1',
      nameEn: 'Extra Protein',
      nameZh: '额外蛋白质',
      descriptionEn: 'Additional chicken breast or tofu',
      descriptionZh: '额外鸡胸肉或豆腐',
      price: 5.99,
      image: 'assets/images/addon_placeholder.png',
    ),
    const AddOnItem(
      id: 'addon2',
      nameEn: 'Brown Rice',
      nameZh: '糙米',
      descriptionEn: 'Healthy brown rice instead of white rice',
      descriptionZh: '健康糙米替代白米饭',
      price: 2.99,
      image: 'assets/images/addon_placeholder.png',
    ),
    const AddOnItem(
      id: 'addon3',
      nameEn: 'Extra Spicy',
      nameZh: '额外辣',
      descriptionEn: 'Add extra chili and spices',
      descriptionZh: '添加额外辣椒和香料',
      price: 1.99,
      image: 'assets/images/addon_placeholder.png',
    ),
    const AddOnItem(
      id: 'addon4',
      nameEn: 'Extra Sauce',
      nameZh: '额外酱料',
      descriptionEn: 'Additional sauce on the side',
      descriptionZh: '额外酱料单独包装',
      price: 1.50,
      image: 'assets/images/addon_placeholder.png',
    ),
    const AddOnItem(
      id: 'addon5',
      nameEn: 'Steamed Vegetables',
      nameZh: '蒸蔬菜',
      descriptionEn: 'Side of steamed mixed vegetables',
      descriptionZh: '配菜蒸混合蔬菜',
      price: 3.99,
      image: 'assets/images/addon_placeholder.png',
    ),
  ];

  // Get add-ons by category (if needed in the future)
  static List<AddOnItem> getAddOnsByCategory(String category) {
    // You can implement categorization logic here
    return sampleAddOns;
  }

  // Find add-on by ID
  static AddOnItem? getAddOnById(String id) {
    try {
      return sampleAddOns.firstWhere((addon) => addon.id == id);
    } catch (e) {
      return null;
    }
  }
}
