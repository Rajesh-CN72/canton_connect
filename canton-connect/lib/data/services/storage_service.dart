// D:\FlutterProjects\Home_Cook\canton_connect\lib\data\services\storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/address_model.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Address storage methods
  Future<void> saveAddresses(List<Address> addresses) async {
    final List<String> addressesJson = 
        addresses.map((address) => json.encode(address.toJson())).toList();
    
    await _prefs.setStringList('user_addresses', addressesJson);
  }

  Future<List<Address>> getAddresses() async {
    final List<String>? addressesJson = _prefs.getStringList('user_addresses');
    
    if (addressesJson == null) return [];
    
    return addressesJson.map((jsonString) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Address.fromJson(jsonMap);
    }).toList();
  }

  Future<void> saveDefaultAddress(Address address) async {
    await _prefs.setString('default_address', json.encode(address.toJson()));
  }

  Future<Address?> getDefaultAddress() async {
    final String? addressJson = _prefs.getString('default_address');
    
    if (addressJson == null) return null;
    
    final Map<String, dynamic> jsonMap = json.decode(addressJson);
    return Address.fromJson(jsonMap);
  }

  // User data storage
  Future<void> saveUserToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  String? getUserToken() {
    return _prefs.getString('auth_token');
  }

  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _prefs.setString('user_profile', json.encode(profile));
  }

  Map<String, dynamic>? getUserProfile() {
    final String? profileJson = _prefs.getString('user_profile');
    return profileJson != null ? json.decode(profileJson) : null;
  }

  // App settings
  Future<void> setAppTheme(bool isDark) async {
    await _prefs.setBool('is_dark_theme', isDark);
  }

  bool getAppTheme() {
    return _prefs.getBool('is_dark_theme') ?? false;
  }

  Future<void> setNotificationEnabled(bool enabled) async {
    await _prefs.setBool('notifications_enabled', enabled);
  }

  bool getNotificationEnabled() {
    return _prefs.getBool('notifications_enabled') ?? true;
  }

  // Cart and order storage
  Future<void> saveCartItems(List<Map<String, dynamic>> cartItems) async {
    await _prefs.setString('cart_items', json.encode(cartItems));
  }

  List<Map<String, dynamic>> getCartItems() {
    final String? cartJson = _prefs.getString('cart_items');
    if (cartJson == null) return [];
    
    final List<dynamic> jsonList = json.decode(cartJson);
    return jsonList.cast<Map<String, dynamic>>();
  }

  // Clear all data (logout)
  Future<void> clearAllData() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('user_profile');
    await _prefs.remove('cart_items');
    // Keep addresses and settings if needed, or remove them too
    // await _prefs.remove('user_addresses');
    // await _prefs.remove('default_address');
  }

  // Utility methods
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }

  Future<void> removeKey(String key) async {
    await _prefs.remove(key);
  }
}
