import 'package:flutter/foundation.dart';
import 'package:canton_connect/data/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  UserRole? _pendingRegistrationRole;
  UserModel? _user;
  
  AuthProvider() {
    // Initialize without notifying listeners during construction
    _initializeSilently();
  }
  
  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _user != null;
  
  // Role-based getters
  bool get isAdmin => _user?.isAdmin ?? false;
  bool get isCustomer => _user?.isCustomer ?? false;
  bool get isVendor => _user?.isVendor ?? false;
  
  // Registration flow control
  UserRole? get pendingRegistrationRole => _pendingRegistrationRole;
  
  // 🔐 GENERIC LOGIN METHOD
  Future<bool> login(String email, String password) async {
    // Default to customer login for generic login method
    return _login(email, password, UserRole.customer);
  }
  
  // 🔐 CUSTOMER AUTHENTICATION
  Future<bool> customerLogin(String email, String password) async {
    return _login(email, password, UserRole.customer);
  }
  
  Future<bool> customerRegister(String email, String password, String name, String? phone) async {
    return _register(email, password, name, phone, UserRole.customer);
  }
  
  // 👑 ADMIN AUTHENTICATION  
  Future<bool> adminLogin(String email, String password) async {
    return _login(email, password, UserRole.admin);
  }
  
  Future<bool> adminRegister(String email, String password, String name, String? phone, String invitationCode) async {
    // Validate invitation code first
    if (!_validateAdminInvitationCode(invitationCode)) {
      _error = 'Invalid admin invitation code';
      notifyListeners();
      return false;
    }
    
    return _register(email, password, name, phone, UserRole.admin);
  }
  
  // 🛠️ VENDOR AUTHENTICATION
  Future<bool> vendorLogin(String email, String password) async {
    return _login(email, password, UserRole.vendor);
  }
  
  Future<bool> vendorRegister(String email, String password, String name, String? phone, String businessLicense) async {
    // Validate business license, etc.
    return _register(email, password, name, phone, UserRole.vendor);
  }
  
  // 🔧 CORE AUTH METHODS (Private)
  Future<bool> _login(String email, String password, UserRole expectedRole) async {
    _setLoading(true);
    _error = null;
    
    try {
      // For demo purposes - simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Demo authentication logic
      if (email.isNotEmpty && password.isNotEmpty && password.length >= 6) {
        // Create a demo user
        _user = UserModel(
          id: '1',
          email: email,
          name: email.split('@').first,
          role: expectedRole,
          phone: '+1234567890',
          createdAt: DateTime.now(),
          isEmailVerified: true,
        );
        
        _setLoading(false);
        return true;
      } else {
        _error = 'Invalid email or password';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }
  
  Future<bool> _register(String email, String password, String name, String? phone, UserRole role) async {
    _setLoading(true);
    _error = null;
    
    try {
      // For demo purposes - simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Demo registration logic
      if (email.isNotEmpty && password.length >= 6 && name.isNotEmpty) {
        _user = UserModel(
          id: '1',
          email: email,
          name: name,
          role: role,
          phone: phone,
          createdAt: DateTime.now(),
          isEmailVerified: false,
        );
        
        _setLoading(false);
        return true;
      } else {
        _error = 'Please fill all required fields correctly';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }
  
  // 📧 PASSWORD RESET
  Future<bool> resetPassword(String email, {UserRole? userRole}) async {
    _setLoading(true);
    _error = null;
    
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      _setLoading(false);
      return true;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }
  
  // 🚪 LOGOUT
  Future<void> logout() async {
    // Simulate logout process
    await Future.delayed(const Duration(milliseconds: 500));
    _user = null;
    _pendingRegistrationRole = null;
    notifyListeners();
  }
  
  // 🔄 INITIALIZATION - Modified to avoid build conflicts
  Future<void> initialize() async {
    // For demo - no persistent user, so just set initial state
    // Don't call _setLoading here to avoid notifications during build
    _isLoading = false;
    _user = null;
    // Don't call notifyListeners() here
  }
  
  // Silent initialization for constructor
  void _initializeSilently() async {
    _isLoading = false;
    _user = null;
    // No notifyListeners() call
  }
  
  // 🎯 REGISTRATION FLOW MANAGEMENT
  void setPendingRegistrationRole(UserRole role) {
    _pendingRegistrationRole = role;
    notifyListeners();
  }
  
  void clearPendingRegistration() {
    _pendingRegistrationRole = null;
    notifyListeners();
  }
  
  // ✅ VALIDATION METHODS
  bool _validateAdminInvitationCode(String code) {
    // In real app, this would call an API
    const validCodes = ['ADMIN2024', 'SUPERUSER', 'RESTAURANT_MGR'];
    return validCodes.contains(code);
  }
  
  bool validateEmailForRole(String email, UserRole role) {
    switch (role) {
      case UserRole.admin:
        return email.toLowerCase().contains('admin') || 
               email.toLowerCase().contains('canton');
      case UserRole.vendor:
        return email.toLowerCase().contains('vendor') ||
               email.toLowerCase().contains('business');
      case UserRole.customer:
        return true; // No restrictions for customers
    }
  }
  
  // 🛡️ ROLE-BASED ACCESS CONTROL
  bool hasPermission(String permission) {
    if (_user == null) return false;
    
    // Define permissions for each role
    final permissions = {
      UserRole.admin: [
        'manage_users', 'manage_foods', 'view_analytics', 
        'manage_orders', 'system_settings'
      ],
      UserRole.vendor: [
        'manage_own_foods', 'view_own_orders', 'vendor_analytics'
      ],
      UserRole.customer: [
        'place_orders', 'view_own_orders', 'manage_profile'
      ],
    };
    
    return permissions[_user!.role]?.contains(permission) ?? false;
  }
  
  // ⚙️ PRIVATE METHODS
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  // 🔄 UPDATE USER PROFILE
  Future<bool> updateProfile({String? name, String? phone, String? address}) async {
    if (_user == null) return false;
    
    _setLoading(true);
    try {
      final updatedUser = _user!.copyWith(
        name: name,
        phone: phone,
        address: address,
      );
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      _user = updatedUser;
      _setLoading(false);
      return true;
    } catch (e) {
      _error = e.toString();
      _setLoading(false);
      return false;
    }
  }
  
  // 🎭 DEMO METHODS FOR TESTING
  void demoLoginAsCustomer() {
    _user = UserModel(
      id: '1',
      email: 'customer@example.com',
      name: 'Demo Customer',
      role: UserRole.customer,
      phone: '+1234567890',
      createdAt: DateTime.now(),
      isEmailVerified: true,
    );
    notifyListeners();
  }
  
  void demoLoginAsAdmin() {
    _user = UserModel(
      id: '2',
      email: 'admin@cantonconnect.com',
      name: 'Demo Admin',
      role: UserRole.admin,
      phone: '+1234567890',
      createdAt: DateTime.now(),
      isEmailVerified: true,
    );
    notifyListeners();
  }
}

