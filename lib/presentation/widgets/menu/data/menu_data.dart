import 'package:canton_connect/data/models/food_item.dart';

class MenuData {
  static List<FoodItem> get sampleFoodItems => [
    // Appetizers
    FoodItem(
      id: '1',
      nameEn: 'Spring Rolls',
      nameZh: '春卷',
      descriptionEn: 'Crispy fried spring rolls filled with vegetables and served with sweet and sour sauce',
      descriptionZh: '酥脆炸春卷，内馅蔬菜，配甜酸酱',
      price: 8.99,
      images: [
        'assets/images/foods/appetizers/spring_rolls.jpg',
        'assets/images/menu/spring_rolls.jpg',
      ],
      rating: 4.3,
      reviewCount: 89,
      cookingTime: 15,
      isSpicy: false,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Carrots', 'Cabbage', 'Mushrooms', 'Spring Roll Wrappers', 'Vermicelli'],
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
          id: 'addon_app_1',
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
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: ['vegetarian', 'vegan'],
      maxOrderPerWeek: 5,
    ),

    FoodItem(
      id: '2',
      nameEn: 'Pork Dumplings',
      nameZh: '猪肉饺子',
      descriptionEn: 'Steamed pork dumplings with ginger and scallions, served with soy-vinegar dipping sauce',
      descriptionZh: '蒸猪肉饺子，配姜和葱，佐以酱油醋蘸酱',
      price: 12.99,
      images: [
        'assets/images/foods/appetizers/pork_dumplings.jpg',
        'assets/images/menu/spring_rolls.jpg',
      ],
      rating: 4.7,
      reviewCount: 156,
      cookingTime: 12,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Ground Pork', 'Ginger', 'Scallions', 'Dumpling Wrappers', 'Soy Sauce'],
      allergens: ['Wheat', 'Soy'],
      nutritionInfo: NutritionInfo(
        calories: 220,
        protein: 12,
        carbs: 18,
        fat: 10,
        fiber: 1,
        sugar: 2,
        sodium: 480,
      ),
      addOns: [
        AddOn(
          id: 'addon_app_2',
          nameEn: 'Chili Oil',
          nameZh: '辣椒油',
          descriptionEn: 'Spicy chili oil for dipping',
          descriptionZh: '辣油蘸酱',
          price: 1.00,
          isAvailable: true,
        ),
      ],
      category: 'Appetizers',
      subCategory: 'Pork',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: [],
      maxOrderPerWeek: 5,
    ),

    // Main Course - Chicken
    FoodItem(
      id: '3',
      nameEn: 'Kung Pao Chicken',
      nameZh: '宫保鸡丁',
      descriptionEn: 'Spicy stir-fried chicken with peanuts, vegetables, and chili peppers in a savory sauce',
      descriptionZh: '香辣可口的宫保鸡丁，配以花生和蔬菜',
      price: 18.99,
      images: [
        'assets/images/foods/main_course/kung_pao_chicken.jpg',
        'assets/images/menu/kung_pao_chicken.jpg',
      ],
      rating: 4.5,
      reviewCount: 128,
      cookingTime: 20,
      isSpicy: true,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Chicken Breast', 'Peanuts', 'Bell Peppers', 'Chili', 'Soy Sauce', 'Ginger', 'Garlic'],
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
      addOns: [
        AddOn(
          id: 'addon_1',
          nameEn: 'Extra Spicy',
          nameZh: '加辣',
          descriptionEn: 'Add extra chili for more heat',
          descriptionZh: '额外加辣',
          price: 1.00,
          isAvailable: true,
        ),
        AddOn(
          id: 'addon_2',
          nameEn: 'Brown Rice',
          nameZh: '糙米饭',
          descriptionEn: 'Upgrade to healthy brown rice',
          descriptionZh: '升级为健康糙米饭',
          price: 2.50,
          isAvailable: true,
        ),
        AddOn(
          id: 'addon_3',
          nameEn: 'Extra Peanuts',
          nameZh: '额外花生',
          descriptionEn: 'Additional roasted peanuts',
          descriptionZh: '额外烤花生',
          price: 1.50,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Chicken',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: ['spicy'],
      maxOrderPerWeek: 3,
    ),

    FoodItem(
      id: '4',
      nameEn: 'Sweet and Sour Pork',
      nameZh: '咕噜肉',
      descriptionEn: 'Crispy fried pork in a classic sweet and sour sauce with pineapple and vegetables',
      descriptionZh: '酥脆炸猪肉配经典酸甜酱，菠萝和蔬菜',
      price: 17.99,
      images: [
        'assets/images/foods/main_course/sweet_sour_pork.jpg',
        'assets/images/menu/sweet_sour_pork.jpg',
      ],
      rating: 4.5,
      reviewCount: 103,
      cookingTime: 20,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Pork Loin', 'Pineapple', 'Bell Peppers', 'Onion', 'Vinegar', 'Sugar'],
      allergens: [],
      nutritionInfo: NutritionInfo(
        calories: 340,
        protein: 20,
        carbs: 28,
        fat: 16,
        fiber: 2,
        sugar: 20,
        sodium: 680,
      ),
      addOns: [
        AddOn(
          id: 'addon_4',
          nameEn: 'Extra Sauce',
          nameZh: '额外酱汁',
          descriptionEn: 'More sweet and sour sauce',
          descriptionZh: '更多酸甜酱',
          price: 1.00,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Pork',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: [],
      maxOrderPerWeek: 3,
    ),

    // Main Course - Beef
    FoodItem(
      id: '5',
      nameEn: 'Beef with Broccoli',
      nameZh: '西兰花牛肉',
      descriptionEn: 'Tender beef slices stir-fried with fresh broccoli in a savory brown sauce',
      descriptionZh: '嫩牛肉片与新鲜西兰花炒制，配香浓酱汁',
      price: 19.99,
      images: [
        'assets/images/foods/main_course/beef_broccoli.jpg',
        'assets/images/menu/vegetable_stir_fry.jpg',
      ],
      rating: 4.6,
      reviewCount: 112,
      cookingTime: 22,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Beef Sirloin', 'Broccoli', 'Garlic', 'Oyster Sauce', 'Soy Sauce'],
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
      addOns: [
        AddOn(
          id: 'addon_5',
          nameEn: 'Extra Broccoli',
          nameZh: '额外西兰花',
          descriptionEn: 'Additional fresh broccoli',
          descriptionZh: '额外新鲜西兰花',
          price: 2.00,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Beef',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: [],
      maxOrderPerWeek: 3,
    ),

    // Main Course - Seafood
    FoodItem(
      id: '6',
      nameEn: 'Kung Pao Shrimp',
      nameZh: '宫保虾球',
      descriptionEn: 'Spicy stir-fried shrimp with peanuts and vegetables in a savory sauce',
      descriptionZh: '香辣虾球配花生和蔬菜',
      price: 22.99,
      images: [
        'assets/images/foods/seafood/kung_pao_shrimp.jpg',
        'assets/images/youth/shrimp.jpg',
      ],
      rating: 4.7,
      reviewCount: 89,
      cookingTime: 18,
      isSpicy: true,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Large Shrimp', 'Peanuts', 'Bell Peppers', 'Chili', 'Ginger', 'Garlic'],
      allergens: ['Peanuts', 'Shellfish'],
      nutritionInfo: NutritionInfo(
        calories: 240,
        protein: 26,
        carbs: 10,
        fat: 12,
        fiber: 2,
        sugar: 4,
        sodium: 720,
      ),
      addOns: [
        AddOn(
          id: 'addon_6',
          nameEn: 'Extra Shrimp',
          nameZh: '额外虾球',
          descriptionEn: 'Additional large shrimp',
          descriptionZh: '额外大虾球',
          price: 4.00,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Seafood',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: ['spicy', 'seafood'],
      maxOrderPerWeek: 3,
    ),

    FoodItem(
      id: '7',
      nameEn: 'Steamed Fish with Ginger',
      nameZh: '姜葱蒸鱼',
      descriptionEn: 'Fresh fish steamed with ginger, scallions, and light soy sauce',
      descriptionZh: '新鲜鱼配姜葱清蒸，淋上淡酱油',
      price: 24.99,
      images: [
        'assets/images/foods/seafood/steamed_fish.jpg',
        'assets/images/menu/steamed_fish.jpg',
      ],
      rating: 4.6,
      reviewCount: 76,
      cookingTime: 25,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Whole Fish', 'Ginger', 'Scallions', 'Light Soy Sauce', 'Sesame Oil'],
      allergens: ['Fish', 'Soy'],
      nutritionInfo: NutritionInfo(
        calories: 190,
        protein: 32,
        carbs: 2,
        fat: 6,
        fiber: 1,
        sugar: 1,
        sodium: 580,
      ),
      addOns: [
        AddOn(
          id: 'addon_7',
          nameEn: 'Extra Ginger',
          nameZh: '额外姜丝',
          descriptionEn: 'Additional fresh ginger',
          descriptionZh: '额外新鲜姜丝',
          price: 1.00,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Seafood',
      isPopular: true,
      isNew: false,
      serves: 2,
      isFeatured: true,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: ['seafood'],
      maxOrderPerWeek: 2,
    ),

    // Vegetarian Main Courses
    FoodItem(
      id: '8',
      nameEn: 'Buddha\'s Delight',
      nameZh: '罗汉斋',
      descriptionEn: 'Mixed vegetables and tofu in a light savory sauce, traditional Buddhist vegetarian dish',
      descriptionZh: '混合蔬菜和豆腐，清淡酱汁，传统佛教素食',
      price: 15.99,
      images: [
        'assets/images/foods/vegetarian/buddhas_delight.jpg',
        'assets/images/menu/vegetable_stir_fry.jpg',
      ],
      rating: 4.4,
      reviewCount: 67,
      cookingTime: 15,
      isSpicy: false,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Tofu', 'Mushrooms', 'Bamboo Shoots', 'Carrots', 'Snow Peas', 'Cabbage'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 180,
        protein: 12,
        carbs: 15,
        fat: 8,
        fiber: 6,
        sugar: 7,
        sodium: 420,
      ),
      addOns: [
        AddOn(
          id: 'addon_8',
          nameEn: 'Extra Tofu',
          nameZh: '额外豆腐',
          descriptionEn: 'Additional firm tofu',
          descriptionZh: '额外硬豆腐',
          price: 2.00,
          isAvailable: true,
        ),
      ],
      category: 'Healthy Options',
      subCategory: 'Vegetarian',
      isPopular: false,
      isNew: true,
      serves: 2,
      isFeatured: false,
      availableInSubscription: true,
      availableInFamilyPackage: true,
      dietaryTags: ['vegetarian', 'vegan', 'healthy'],
      maxOrderPerWeek: 5,
    ),

    FoodItem(
      id: '9',
      nameEn: 'Mapo Tofu',
      nameZh: '麻婆豆腐',
      descriptionEn: 'Soft tofu in a spicy chili and bean-based sauce, traditionally with minced meat (vegetarian version)',
      descriptionZh: '嫩豆腐配麻辣酱汁（素食版本）',
      price: 14.99,
      images: [
        'assets/images/foods/vegetarian/mapo_tofu.jpg',
        'assets/images/menu/mapo_tofu.jpg',
      ],
      rating: 4.5,
      reviewCount: 92,
      cookingTime: 12,
      isSpicy: true,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Soft Tofu', 'Chili Bean Paste', 'Sichuan Peppercorns', 'Garlic', 'Ginger'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 160,
        protein: 10,
        carbs: 8,
        fat: 9,
        fiber: 2,
        sugar: 3,
        sodium: 680,
      ),
      addOns: [
        AddOn(
          id: 'addon_9',
          nameEn: 'Extra Spicy',
          nameZh: '加麻加辣',
          descriptionEn: 'Add extra Sichuan peppercorns and chili',
          descriptionZh: '额外花椒和辣椒',
          price: 1.50,
          isAvailable: true,
        ),
      ],
      category: 'Healthy Options',
      subCategory: 'Vegetarian',
    ),

    // Rice & Noodles
    FoodItem(
      id: '10',
      nameEn: 'Yangzhou Fried Rice',
      nameZh: '扬州炒饭',
      descriptionEn: 'Classic fried rice with shrimp, chicken, eggs, and mixed vegetables',
      descriptionZh: '经典扬州炒饭，配虾仁、鸡肉、鸡蛋和混合蔬菜',
      price: 13.99,
      images: [
        'assets/images/foods/rice_noodles/yangzhou_rice.jpg',
        'assets/images/menu/fried_rice.jpg',
      ],
      rating: 4.6,
      reviewCount: 134,
      cookingTime: 15,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Rice', 'Shrimp', 'Chicken', 'Eggs', 'Peas', 'Carrots', 'Scallions'],
      allergens: ['Eggs', 'Shellfish'],
      nutritionInfo: NutritionInfo(
        calories: 380,
        protein: 18,
        carbs: 45,
        fat: 12,
        fiber: 3,
        sugar: 4,
        sodium: 620,
      ),
      addOns: [
        AddOn(
          id: 'addon_10',
          nameEn: 'Extra Protein',
          nameZh: '额外蛋白质',
          descriptionEn: 'Additional shrimp and chicken',
          descriptionZh: '额外虾仁和鸡肉',
          price: 3.00,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Rice',
    ),

    FoodItem(
      id: '11',
      nameEn: 'Beef Chow Fun',
      nameZh: '干炒牛河',
      descriptionEn: 'Stir-fried wide rice noodles with beef, bean sprouts, and scallions',
      descriptionZh: '炒宽河粉配牛肉、豆芽和葱段',
      price: 16.99,
      images: [
        'assets/images/foods/rice_noodles/beef_chow_fun.jpg',
        'assets/images/menu/fried_rice.jpg',
      ],
      rating: 4.7,
      reviewCount: 118,
      cookingTime: 18,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Wide Rice Noodles', 'Beef', 'Bean Sprouts', 'Scallions', 'Dark Soy Sauce'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 420,
        protein: 22,
        carbs: 55,
        fat: 14,
        fiber: 3,
        sugar: 5,
        sodium: 780,
      ),
      addOns: [
        AddOn(
          id: 'addon_11',
          nameEn: 'Extra Beef',
          nameZh: '额外牛肉',
          descriptionEn: 'Additional tender beef slices',
          descriptionZh: '额外嫩牛肉片',
          price: 3.50,
          isAvailable: true,
        ),
      ],
      category: 'Main Courses',
      subCategory: 'Noodles',
    ),

    // Family Packages (High-priced items)
    FoodItem(
      id: '12',
      nameEn: 'Family Feast Platter',
      nameZh: '家庭盛宴拼盘',
      descriptionEn: 'Large platter with Kung Pao Chicken, Sweet and Sour Pork, Beef with Broccoli, and Yangzhou Fried Rice - serves 4-5 people',
      descriptionZh: '大拼盘包含宫保鸡丁、咕噜肉、西兰花牛肉和扬州炒饭 - 适合4-5人',
      price: 49.99,
      images: [
        'assets/images/foods/family_packages/family_feast.jpg',
        'assets/images/menu/family_feast.jpg',
        'assets/images/family/combo_a.jpg',
      ],
      rating: 4.8,
      reviewCount: 56,
      cookingTime: 30,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Chicken', 'Pork', 'Beef', 'Rice', 'Mixed Vegetables', 'Various Sauces'],
      allergens: ['Peanuts', 'Soy'],
      nutritionInfo: NutritionInfo(
        calories: 1250,
        protein: 85,
        carbs: 120,
        fat: 45,
        fiber: 12,
        sugar: 35,
        sodium: 2200,
      ),
      addOns: [
        AddOn(
          id: 'addon_12',
          nameEn: 'Extra Spring Rolls',
          nameZh: '额外春卷',
          descriptionEn: 'Add 8 spring rolls to your feast',
          descriptionZh: '为盛宴添加8个春卷',
          price: 8.99,
          isAvailable: true,
        ),
        AddOn(
          id: 'addon_13',
          nameEn: 'Fortune Cookies',
          nameZh: '幸运饼干',
          descriptionEn: 'Pack of 6 fortune cookies',
          descriptionZh: '6个幸运饼干',
          price: 3.00,
          isAvailable: true,
        ),
      ],
      category: 'Family Packages',
      subCategory: 'Combo',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    FoodItem(
      id: '13',
      nameEn: 'Seafood Banquet',
      nameZh: '海鲜宴',
      descriptionEn: 'Premium seafood platter with Kung Pao Shrimp, Steamed Fish, and seafood fried rice - serves 3-4 people',
      descriptionZh: '高级海鲜拼盘包含宫保虾球、清蒸鱼和海鲜炒饭 - 适合3-4人',
      price: 59.99,
      images: [
        'assets/images/foods/family_packages/seafood_banquet.jpg',
        'assets/images/family/combo_b.jpg',
      ],
      rating: 4.9,
      reviewCount: 42,
      cookingTime: 35,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Shrimp', 'Whole Fish', 'Scallops', 'Rice', 'Mixed Vegetables'],
      allergens: ['Shellfish', 'Fish'],
      nutritionInfo: NutritionInfo(
        calories: 980,
        protein: 95,
        carbs: 85,
        fat: 28,
        fiber: 8,
        sugar: 12,
        sodium: 1800,
      ),
      addOns: [
        AddOn(
          id: 'addon_14',
          nameEn: 'Lobster Tail',
          nameZh: '龙虾尾',
          descriptionEn: 'Add a grilled lobster tail',
          descriptionZh: '添加烤龙虾尾',
          price: 15.99,
          isAvailable: true,
        ),
      ],
      category: 'Family Packages',
      subCategory: 'Seafood',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Desserts
    FoodItem(
      id: '14',
      nameEn: 'Mango Pudding',
      nameZh: '芒果布丁',
      descriptionEn: 'Refreshing mango-flavored pudding served chilled with fresh mango pieces',
      descriptionZh: '清爽芒果味布丁，冷藏后配新鲜芒果块',
      price: 6.99,
      images: [
        'assets/images/foods/desserts/mango_pudding.jpg',
        'assets/images/menu/mango_pudding.jpg',
        'assets/images/desserts/mango.jpg',
      ],
      rating: 4.5,
      reviewCount: 78,
      cookingTime: 0,
      isSpicy: false,
      isVegetarian: true,
      isVegan: false,
      ingredients: ['Mango', 'Milk', 'Sugar', 'Gelatin'],
      allergens: ['Dairy'],
      nutritionInfo: NutritionInfo(
        calories: 120,
        protein: 3,
        carbs: 25,
        fat: 2,
        fiber: 1,
        sugar: 22,
        sodium: 45,
      ),
      addOns: [
        AddOn(
          id: 'addon_15',
          nameEn: 'Extra Mango',
          nameZh: '额外芒果',
          descriptionEn: 'Additional fresh mango pieces',
          descriptionZh: '额外新鲜芒果块',
          price: 1.50,
          isAvailable: true,
        ),
      ],
      category: 'Desserts',
      subCategory: 'Pudding',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    FoodItem(
      id: '15',
      nameEn: 'Sesame Balls',
      nameZh: '煎堆',
      descriptionEn: 'Crispy fried glutinous rice balls filled with sweet red bean paste, coated with sesame seeds',
      descriptionZh: '酥脆炸糯米球，内馅甜红豆沙，外裹芝麻',
      price: 7.99,
      images: [
        'assets/images/foods/desserts/sesame_balls.jpg',
        'assets/images/desserts/redbean.jpg',
      ],
      rating: 4.4,
      reviewCount: 63,
      cookingTime: 10,
      isSpicy: false,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Glutinous Rice Flour', 'Red Bean Paste', 'Sesame Seeds', 'Sugar'],
      allergens: ['Sesame'],
      nutritionInfo: NutritionInfo(
        calories: 180,
        protein: 4,
        carbs: 32,
        fat: 5,
        fiber: 2,
        sugar: 18,
        sodium: 25,
      ),
      addOns: [],
      category: 'Desserts',
      subCategory: 'Fried Dessert',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Drinks
    FoodItem(
      id: '16',
      nameEn: 'Bubble Milk Tea',
      nameZh: '珍珠奶茶',
      descriptionEn: 'Classic milk tea with chewy tapioca pearls, customizable sweetness level',
      descriptionZh: '经典奶茶配嚼劲珍珠，可调甜度',
      price: 5.99,
      images: [
        'assets/images/foods/drinks/bubble_tea.jpg',
        'assets/images/menu/bubble_tea.jpg',
      ],
      rating: 4.6,
      reviewCount: 145,
      cookingTime: 5,
      isSpicy: false,
      isVegetarian: true,
      isVegan: false,
      ingredients: ['Black Tea', 'Milk', 'Tapioca Pearls', 'Sugar'],
      allergens: ['Dairy'],
      nutritionInfo: NutritionInfo(
        calories: 220,
        protein: 4,
        carbs: 45,
        fat: 3,
        fiber: 1,
        sugar: 35,
        sodium: 85,
      ),
      addOns: [
        AddOn(
          id: 'addon_16',
          nameEn: 'Extra Pearls',
          nameZh: '额外珍珠',
          descriptionEn: 'Additional tapioca pearls',
          descriptionZh: '额外珍珠',
          price: 0.75,
          isAvailable: true,
        ),
        AddOn(
          id: 'addon_17',
          nameEn: 'Grass Jelly',
          nameZh: '仙草',
          descriptionEn: 'Add grass jelly topping',
          descriptionZh: '添加仙草 topping',
          price: 1.00,
          isAvailable: true,
        ),
      ],
      category: 'Drinks',
      subCategory: 'Tea',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Youth Favorites
    FoodItem(
      id: '17',
      nameEn: 'Crispy Chicken',
      nameZh: '脆皮鸡',
      descriptionEn: 'Extra crispy fried chicken with special seasoning',
      descriptionZh: '特脆炸鸡配特制调味料',
      price: 14.99,
      images: [
        'assets/images/youth/chicken.jpg',
        'assets/images/menu/kung_pao_chicken.jpg',
      ],
      rating: 4.6,
      reviewCount: 203,
      cookingTime: 18,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Chicken Thighs', 'Special Seasoning', 'Flour', 'Spices'],
      allergens: ['Wheat'],
      nutritionInfo: NutritionInfo(
        calories: 320,
        protein: 22,
        carbs: 18,
        fat: 18,
        fiber: 1,
        sugar: 2,
        sodium: 680,
      ),
      addOns: [
        AddOn(
          id: 'addon_18',
          nameEn: 'Extra Crispy',
          nameZh: '更酥脆',
          descriptionEn: 'Make it extra crispy',
          descriptionZh: '更加酥脆',
          price: 1.50,
          isAvailable: true,
        ),
      ],
      category: 'Youth Favorites',
      subCategory: 'Chicken',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Signature Dishes
    FoodItem(
      id: '18',
      nameEn: 'Signature Roast Duck',
      nameZh: '招牌烤鸭',
      descriptionEn: 'Traditional Cantonese roast duck with crispy skin and tender meat',
      descriptionZh: '传统广式烤鸭，皮脆肉嫩',
      price: 28.99,
      images: [
        'assets/images/signature/duck.jpg',
        'assets/images/menu/weekend_special.jpg',
      ],
      rating: 4.8,
      reviewCount: 167,
      cookingTime: 45,
      isSpicy: false,
      isVegetarian: false,
      isVegan: false,
      ingredients: ['Whole Duck', 'Five-spice Powder', 'Honey', 'Soy Sauce', 'Chinese Wine'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 280,
        protein: 25,
        carbs: 8,
        fat: 16,
        fiber: 1,
        sugar: 6,
        sodium: 720,
      ),
      addOns: [
        AddOn(
          id: 'addon_19',
          nameEn: 'Extra Pancakes',
          nameZh: '额外薄饼',
          descriptionEn: 'Additional steamed pancakes',
          descriptionZh: '额外蒸薄饼',
          price: 3.00,
          isAvailable: true,
        ),
      ],
      category: 'Signature Dishes',
      subCategory: 'Duck',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Soups
    FoodItem(
      id: '19',
      nameEn: 'Hot and Sour Soup',
      nameZh: '酸辣汤',
      descriptionEn: 'Classic Chinese soup with a balance of spicy and sour flavors, filled with tofu, mushrooms, and bamboo shoots',
      descriptionZh: '经典酸辣汤，辣酸平衡，配豆腐、蘑菇和竹笋',
      price: 9.99,
      images: [
        'assets/images/menu/hot_pot.jpg',
        'assets/images/background/app_background.jpg',
      ],
      rating: 4.4,
      reviewCount: 98,
      cookingTime: 15,
      isSpicy: true,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Tofu', 'Mushrooms', 'Bamboo Shoots', 'Vinegar', 'White Pepper', 'Soy Sauce'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 120,
        protein: 8,
        carbs: 15,
        fat: 3,
        fiber: 2,
        sugar: 4,
        sodium: 850,
      ),
      addOns: [
        AddOn(
          id: 'addon_20',
          nameEn: 'Extra Spicy',
          nameZh: '加辣',
          descriptionEn: 'Make it extra spicy',
          descriptionZh: '更加辣',
          price: 0.50,
          isAvailable: true,
        ),
      ],
      category: 'Soups',
      subCategory: 'Vegetarian',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),

    // Healthy Options - Additional
    FoodItem(
      id: '20',
      nameEn: 'Steamed Vegetables',
      nameZh: '蒸蔬菜',
      descriptionEn: 'Fresh seasonal vegetables steamed to perfection, served with light soy sauce',
      descriptionZh: '新鲜时令蔬菜完美蒸制，配淡酱油',
      price: 11.99,
      images: [
        'assets/images/healthy/vegetables.jpg',
        'assets/images/menu/vegetable_stir_fry.jpg',
      ],
      rating: 4.2,
      reviewCount: 54,
      cookingTime: 10,
      isSpicy: false,
      isVegetarian: true,
      isVegan: true,
      ingredients: ['Seasonal Vegetables', 'Light Soy Sauce', 'Ginger', 'Garlic'],
      allergens: ['Soy'],
      nutritionInfo: NutritionInfo(
        calories: 80,
        protein: 4,
        carbs: 12,
        fat: 2,
        fiber: 5,
        sugar: 6,
        sodium: 320,
      ),
      addOns: [
        AddOn(
          id: 'addon_21',
          nameEn: 'Brown Rice',
          nameZh: '糙米饭',
          descriptionEn: 'Side of brown rice',
          descriptionZh: '配糙米饭',
          price: 2.50,
          isAvailable: true,
        ),
      ],
      category: 'Healthy Options',
      subCategory: 'Vegetables',
      isPopular: true,
      isNew: false,
      serves: 5,
      isFeatured: true,
      availableInSubscription: false, // Family packages usually not in subscriptions
      availableInFamilyPackage: true,
      dietaryTags: ['family', 'combo'],
      maxOrderPerWeek: 2,
    ),
  ];

  // Updated categories with proper images
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

  // Category images mapping
  static Map<String, String> get categoryImages => {
    'All': 'assets/images/hero/hero_dish.png',
    'Family Packages': 'assets/images/family/combo_a.jpg',
    'Signature Dishes': 'assets/images/signature/duck.jpg',
    'Youth Favorites': 'assets/images/youth/chicken.jpg',
    'Healthy Options': 'assets/images/healthy/vegetables.jpg',
    'Desserts': 'assets/images/desserts/mango.jpg',
    'Appetizers': 'assets/images/foods/appetizers/spring_rolls.jpg',
    'Main Courses': 'assets/images/foods/main_course/kung_pao_chicken.jpg',
    'Soups': 'assets/images/menu/hot_pot.jpg',
    'Drinks': 'assets/images/foods/drinks/bubble_tea.jpg',
  };

  // Category descriptions
  static Map<String, Map<String, String>> get categoryDescriptions => {
    'All': {
      'en': 'All our delicious dishes',
      'zh': '我们所有的美味菜肴'
    },
    'Family Packages': {
      'en': 'Perfect for family gatherings and celebrations',
      'zh': '适合家庭聚会和庆祝活动'
    },
    'Signature Dishes': {
      'en': 'Our most popular and authentic dishes',
      'zh': '我们最受欢迎的正宗菜肴'
    },
    'Youth Favorites': {
      'en': 'Popular choices among younger customers',
      'zh': '年轻顾客的热门选择'
    },
    'Healthy Options': {
      'en': 'Nutritious and balanced meal choices',
      'zh': '营养均衡的餐点选择'
    },
    'Desserts': {
      'en': 'Sweet treats to complete your meal',
      'zh': '甜点完美结束您的用餐'
    },
    'Appetizers': {
      'en': 'Perfect starters to begin your meal',
      'zh': '完美的开胃菜开始您的用餐'
    },
    'Main Courses': {
      'en': 'Hearty and satisfying main dishes',
      'zh': '丰盛满足的主菜'
    },
    'Soups': {
      'en': 'Warm and comforting soups',
      'zh': '温暖舒适的汤品'
    },
    'Drinks': {
      'en': 'Refreshing beverages to complement your meal',
      'zh': '清爽饮料搭配您的餐点'
    },
  };

  static List<String> get spicyLevels => [
    'Mild',
    'Medium',
    'Spicy',
    'Extra Spicy',
  ];

  // Helper method to get food items by category
  static List<FoodItem> getFoodItemsByCategory(String category) {
    if (category == 'All') {
      return sampleFoodItems;
    }
    return sampleFoodItems.where((item) => item.category == category).toList();
  }

  // Helper method to get food item by ID
  static FoodItem? getFoodItemById(String id) {
    try {
      return sampleFoodItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper method to get category image
  static String getCategoryImage(String category) {
    return categoryImages[category] ?? 'assets/images/food_placeholder.png';
  }

  // Helper method to get category description
  static String getCategoryDescription(String category, String language) {
    final desc = categoryDescriptions[category];
    return desc?[language] ?? (language == 'zh' ? '美味菜肴' : 'Delicious dishes');
  }

  // Helper method to get vegetarian items only
  static List<FoodItem> getVegetarianItems() {
    return sampleFoodItems.where((item) => item.isVegetarian).toList();
  }

  // Helper method to get spicy items only
  static List<FoodItem> getSpicyItems() {
    return sampleFoodItems.where((item) => item.isSpicy).toList();
  }

  // Helper method to get family packages (high-priced items)
  static List<FoodItem> getFamilyPackages() {
    return sampleFoodItems.where((item) => item.category == 'Family Packages').toList();
  }

  // Helper method to get popular items (based on rating > 4.5)
  static List<FoodItem> getPopularItems() {
    return sampleFoodItems.where((item) => item.rating > 4.5).toList();
  }

  // Helper method to get new items (based on review count < 50)
  static List<FoodItem> getNewItems() {
    return sampleFoodItems.where((item) => item.reviewCount < 50).toList();
  }

  // Search food items by name and description
  static List<FoodItem> searchFoodItems(String query, String language) {
    if (query.isEmpty) return [];
    
    return sampleFoodItems.where((item) {
      final name = language == 'zh' ? item.nameZh : item.nameEn;
      final description = language == 'zh' ? item.descriptionZh : item.descriptionEn;
      
      return name.toLowerCase().contains(query.toLowerCase()) ||
             description.toLowerCase().contains(query.toLowerCase()) ||
             item.ingredients.any((ingredient) => 
             ingredient.toLowerCase().contains(query.toLowerCase()));
    }).toList();
  }

  // Get all subcategories for a category
  static List<String> getSubcategories(String category) {
    final subcategories = sampleFoodItems
        .where((item) => item.category == category)
        .map((item) => item.subCategory)
        .toSet();
    return subcategories.toList();
  }

  // Get items with price range
  static List<FoodItem> getItemsByPriceRange(double minPrice, double maxPrice) {
    return sampleFoodItems.where((item) => 
      item.price >= minPrice && item.price <= maxPrice
    ).toList();
  }

  // Get items by cooking time
  static List<FoodItem> getItemsByCookingTime(int maxCookingTime) {
    return sampleFoodItems.where((item) => 
      item.cookingTime <= maxCookingTime
    ).toList();
  }

  // Get featured items for home page
  static List<FoodItem> getFeaturedItems() {
    return [
      getFoodItemById('3')!, // Kung Pao Chicken
      getFoodItemById('12')!, // Family Feast
      getFoodItemById('18')!, // Signature Roast Duck
      getFoodItemById('16')!, // Bubble Tea
    ];
  }
}
