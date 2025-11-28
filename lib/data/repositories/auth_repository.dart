// lib/data/repositories/auth_repository.dart
import 'package:canton_connect/data/models/user_model.dart';

abstract class AuthRepository {
  // Core authentication
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name, String? phone, UserRole role);
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<UserModel?> getCurrentUser();
  Future<bool> isLoggedIn();
  Future<void> updateUserProfile(UserModel user);
  
  // Role-specific methods
  Future<bool> validateAdminInvitation(String code);
  Future<bool> validateVendorLicense(String license);
}

class MockAuthRepository implements AuthRepository {
  final Map<String, UserModel> _users = {
    'admin@canton.com': UserModel(
      id: '1',
      email: 'admin@canton.com',
      name: 'Admin User',
      role: UserRole.admin,
      createdAt: DateTime.now(),
    ),
    'vendor@canton.com': UserModel(
      id: '3',
      email: 'vendor@canton.com',
      name: 'Vendor User',
      role: UserRole.vendor,
      createdAt: DateTime.now(),
    ),
    'customer@canton.com': UserModel(
      id: '2',
      email: 'customer@canton.com',
      name: 'John Doe',
      role: UserRole.customer,
      createdAt: DateTime.now(),
    ),
  };

  UserModel? _currentUser;

  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (_users.containsKey(email) && password == 'password') {
      // ignore: unnecessary_null_checks
      _currentUser = _users[email]!;
      return _currentUser!;
    } else {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name, String? phone, UserRole role) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (_users.containsKey(email)) {
      throw Exception('Email already exists');
    }
    
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      phone: phone,
      role: role,
      createdAt: DateTime.now(),
    );
    
    _users[email] = newUser;
    _currentUser = newUser;
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!_users.containsKey(email)) {
      throw Exception('Email not found');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser;
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  @override
  Future<void> updateUserProfile(UserModel user) async {
    await Future.delayed(const Duration(seconds: 1));
    _users[user.email] = user;
    if (_currentUser?.id == user.id) {
      _currentUser = user;
    }
  }

  @override
  Future<bool> validateAdminInvitation(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    const validCodes = ['ADMIN2024', 'SUPERUSER', 'RESTAURANT_MGR'];
    return validCodes.contains(code);
  }

  @override
  Future<bool> validateVendorLicense(String license) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock validation - in real app, check against business registry
    return license.length >= 5;
  }
}
