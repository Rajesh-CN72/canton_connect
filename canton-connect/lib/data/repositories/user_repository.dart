// User Models
enum UserRole {
  customer,
  restaurantOwner,
  deliveryRider,
  admin,
}

enum UserStatus {
  active,
  inactive,
  suspended,
  pendingVerification,
}

class UserAddress {
  final String id;
  final String title;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final double latitude;
  final double longitude;
  final String? instructions;
  final bool isDefault;

  const UserAddress({
    required this.id,
    required this.title,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    this.instructions,
    this.isDefault = false,
  });

  String get fullAddress {
    final parts = [addressLine1, addressLine2, city, state, zipCode, country];
    return parts.where((part) => part != null && part.isNotEmpty).join(', ');
  }
}

class User {
  final String id;
  final String email;
  final String? phoneNumber;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;
  final UserRole role;
  final UserStatus status;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;
  final List<UserAddress> addresses;
  final double walletBalance;
  final int loyaltyPoints;
  final List<String> favoriteRestaurants;
  final List<String> favoriteMenuItems;

  const User({
    required this.id,
    required this.email,
    this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
    required this.role,
    this.status = UserStatus.active,
    required this.createdAt,
    this.lastLogin,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.addresses = const [],
    this.walletBalance = 0.0,
    this.loyaltyPoints = 0,
    this.favoriteRestaurants = const [],
    this.favoriteMenuItems = const [],
  });

  String get fullName => '$firstName $lastName';
  String get initials => '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'.toUpperCase();
  bool get isEmailVerified => emailVerifiedAt != null;
  bool get isPhoneVerified => phoneVerifiedAt != null;
  bool get isActive => status == UserStatus.active;
  
  UserAddress? get defaultAddress {
    try {
      return addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }
}

// User Repository
class UserRepository {
  User? _currentUser;

  UserRepository() {
    _initializeData();
  }

  void _initializeData() {
    // Mock current user - remove const since DateTime.now() is not constant
    _currentUser = User(
      id: 'user1',
      email: 'john.doe@example.com',
      phoneNumber: '+1234567890',
      firstName: 'John',
      lastName: 'Doe',
      profileImageUrl: 'assets/images/user_avatar.jpg',
      role: UserRole.customer,
      status: UserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLogin: DateTime.now(),
      emailVerifiedAt: DateTime.now().subtract(const Duration(days: 29)),
      phoneVerifiedAt: DateTime.now().subtract(const Duration(days: 28)),
      addresses: const [
        UserAddress(
          id: 'addr1',
          title: 'Home',
          addressLine1: '123 Main Street',
          city: 'New York',
          state: 'NY',
          zipCode: '10001',
          country: 'USA',
          latitude: 40.7128,
          longitude: -74.0060,
          isDefault: true,
        ),
        UserAddress(
          id: 'addr2',
          title: 'Work',
          addressLine1: '456 Business Ave',
          addressLine2: 'Suite 100',
          city: 'New York',
          state: 'NY',
          zipCode: '10002',
          country: 'USA',
          latitude: 40.7138,
          longitude: -74.0070,
        ),
      ],
      walletBalance: 50.0,
      loyaltyPoints: 150,
      favoriteRestaurants: const ['rest1', 'rest2'],
      favoriteMenuItems: const ['3', '5'],
    );
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  // Login
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = User(
        id: 'user1',
        email: email,
        firstName: 'John',
        lastName: 'Doe',
        role: UserRole.customer,
        status: UserStatus.active,
        createdAt: DateTime.now(),
        lastLogin: DateTime.now(),
        emailVerifiedAt: DateTime.now(),
      );
      return _currentUser;
    }
    
    return null;
  }

  // Register
  Future<User?> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    _currentUser = User(
      id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      phoneNumber: phoneNumber,
      firstName: firstName,
      lastName: lastName,
      role: UserRole.customer,
      status: UserStatus.pendingVerification,
      createdAt: DateTime.now(),
    );
    
    return _currentUser;
  }

  // Logout
  Future<bool> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    return true;
  }

  // Update profile
  Future<User?> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (_currentUser == null) return null;
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      firstName: firstName ?? _currentUser!.firstName,
      lastName: lastName ?? _currentUser!.lastName,
      profileImageUrl: profileImageUrl ?? _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: _currentUser!.addresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return _currentUser;
  }

  // Update password
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Add address
  Future<User?> addAddress(UserAddress address) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser == null) return null;
    
    final updatedAddresses = List<UserAddress>.from(_currentUser!.addresses);
    
    if (address.isDefault) {
      for (int i = 0; i < updatedAddresses.length; i++) {
        updatedAddresses[i] = UserAddress(
          id: updatedAddresses[i].id,
          title: updatedAddresses[i].title,
          addressLine1: updatedAddresses[i].addressLine1,
          addressLine2: updatedAddresses[i].addressLine2,
          city: updatedAddresses[i].city,
          state: updatedAddresses[i].state,
          zipCode: updatedAddresses[i].zipCode,
          country: updatedAddresses[i].country,
          latitude: updatedAddresses[i].latitude,
          longitude: updatedAddresses[i].longitude,
          instructions: updatedAddresses[i].instructions,
          isDefault: false,
        );
      }
    }
    
    updatedAddresses.add(address);
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: updatedAddresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return _currentUser;
  }

  // Update address
  Future<User?> updateAddress(String addressId, UserAddress address) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser == null) return null;
    
    final updatedAddresses = _currentUser!.addresses.map((addr) {
      if (addr.id == addressId) {
        return address;
      }
      if (address.isDefault && addr.id != addressId) {
        return UserAddress(
          id: addr.id,
          title: addr.title,
          addressLine1: addr.addressLine1,
          addressLine2: addr.addressLine2,
          city: addr.city,
          state: addr.state,
          zipCode: addr.zipCode,
          country: addr.country,
          latitude: addr.latitude,
          longitude: addr.longitude,
          instructions: addr.instructions,
          isDefault: false,
        );
      }
      return addr;
    }).toList();

    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: updatedAddresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return _currentUser;
  }

  // Remove address
  Future<User?> removeAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser == null) return null;
    
    final updatedAddresses = _currentUser!.addresses.where((addr) => addr.id != addressId).toList();
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: updatedAddresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return _currentUser;
  }

  // Toggle favorite restaurant
  Future<User?> toggleFavoriteRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (_currentUser == null) return null;
    
    final updatedFavorites = List<String>.from(_currentUser!.favoriteRestaurants);
    if (updatedFavorites.contains(restaurantId)) {
      updatedFavorites.remove(restaurantId);
    } else {
      updatedFavorites.add(restaurantId);
    }
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: _currentUser!.addresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: updatedFavorites,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return _currentUser;
  }

  // Toggle favorite menu item
  Future<User?> toggleFavoriteMenuItem(String menuItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (_currentUser == null) return null;
    
    final updatedFavorites = List<String>.from(_currentUser!.favoriteMenuItems);
    if (updatedFavorites.contains(menuItemId)) {
      updatedFavorites.remove(menuItemId);
    } else {
      updatedFavorites.add(menuItemId);
    }
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: _currentUser!.emailVerifiedAt,
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: _currentUser!.addresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: updatedFavorites,
    );
    
    return _currentUser;
  }

  // Get wallet balance
  Future<double> getWalletBalance() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser?.walletBalance ?? 0.0;
  }

  // Verify email
  Future<bool> verifyEmail(String token) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (_currentUser == null) return false;
    
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      phoneNumber: _currentUser!.phoneNumber,
      firstName: _currentUser!.firstName,
      lastName: _currentUser!.lastName,
      profileImageUrl: _currentUser!.profileImageUrl,
      role: _currentUser!.role,
      status: _currentUser!.status,
      createdAt: _currentUser!.createdAt,
      lastLogin: _currentUser!.lastLogin,
      emailVerifiedAt: DateTime.now(),
      phoneVerifiedAt: _currentUser!.phoneVerifiedAt,
      addresses: _currentUser!.addresses,
      walletBalance: _currentUser!.walletBalance,
      loyaltyPoints: _currentUser!.loyaltyPoints,
      favoriteRestaurants: _currentUser!.favoriteRestaurants,
      favoriteMenuItems: _currentUser!.favoriteMenuItems,
    );
    
    return true;
  }

  // Request password reset
  Future<bool> requestPasswordReset(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
