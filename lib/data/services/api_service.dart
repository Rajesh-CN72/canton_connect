// D:\FlutterProjects\Home_Cook\canton_connect\lib\data\services\api_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // ============ PROFILES ============
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', _supabase.auth.currentUser!.id)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  static Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> profile) async {
    try {
      final response = await _supabase
          .from('profiles')
          .update(profile)
          .eq('id', _supabase.auth.currentUser!.id)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // ============ MENU CATEGORIES ============
  static Future<List<dynamic>> getMenuCategories() async {
    try {
      final response = await _supabase
          .from('menu_categories')
          .select()
          .order('sort_order', ascending: true);
      return response;
    } catch (e) {
      throw Exception('Failed to load menu categories: $e');
    }
  }

  // ============ MENU SUBCATEGORIES ============
  static Future<List<dynamic>> getMenuSubcategories(String categoryId) async {
    try {
      final response = await _supabase
          .from('menu_subcategories')
          .select()
          .eq('category_id', categoryId)
          .order('sort_order', ascending: true);
      return response;
    } catch (e) {
      throw Exception('Failed to load menu subcategories: $e');
    }
  }

  // ============ MENU ITEMS ============
  static Future<List<dynamic>> getMenuItems({String? subcategoryId, String? categoryId}) async {
    try {
      var query = _supabase
          .from('menu_items')
          .select('''
            *,
            menu_subcategories (name),
            menu_categories (name)
          ''')
          .eq('is_available', true);

      if (subcategoryId != null) {
        query = query.eq('subcategory_id', subcategoryId);
      } else if (categoryId != null) {
        query = query.eq('category_id', categoryId);
      }

      final response = await query.order('sort_order', ascending: true);
      return response;
    } catch (e) {
      throw Exception('Failed to load menu items: $e');
    }
  }

  static Future<dynamic> getMenuItem(String itemId) async {
    try {
      final response = await _supabase
          .from('menu_items')
          .select('''
            *,
            menu_subcategories (name, description),
            menu_categories (name)
          ''')
          .eq('id', itemId)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to load menu item: $e');
    }
  }

  // ============ ORDERS ============
  static Future<List<dynamic>> getOrders() async {
    try {
      final response = await _supabase
          .from('orders')
          .select('''
            *,
            order_items (
              quantity,
              price,
              menu_items (
                name,
                description,
                image_url
              )
            )
          ''')
          .eq('user_id', _supabase.auth.currentUser!.id)
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  static Future<dynamic> getOrder(String orderId) async {
    try {
      final response = await _supabase
          .from('orders')
          .select('''
            *,
            order_items (
              quantity,
              price,
              menu_items (
                name,
                description,
                image_url
              )
            )
          ''')
          .eq('id', orderId)
          .eq('user_id', _supabase.auth.currentUser!.id)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to load order: $e');
    }
  }

  static Future<dynamic> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _supabase
          .from('orders')
          .insert(orderData)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  static Future<dynamic> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _supabase
          .from('orders')
          .update({'status': status, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', orderId)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  // ============ SUBSCRIPTION PLANS ============
  static Future<List<dynamic>> getSubscriptionPlans() async {
    try {
      final response = await _supabase
          .from('subscription_plans')
          .select()
          .order('price', ascending: true);
      return response;
    } catch (e) {
      throw Exception('Failed to load subscription plans: $e');
    }
  }

  static Future<dynamic> getSubscriptionPlan(String planId) async {
    try {
      final response = await _supabase
          .from('subscription_plans')
          .select()
          .eq('id', planId)
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to load subscription plan: $e');
    }
  }

  // ============ USER SUBSCRIPTION ============
  static Future<dynamic> getUserSubscription() async {
    try {
      final response = await _supabase
          .from('user_subscription')
          .select('''
            *,
            subscription_plans (*)
          ''')
          .eq('user_id', _supabase.auth.currentUser!.id)
          .maybeSingle();
      return response;
    } catch (e) {
      throw Exception('Failed to load user subscription: $e');
    }
  }

  static Future<dynamic> createUserSubscription(Map<String, dynamic> subscriptionData) async {
    try {
      final response = await _supabase
          .from('user_subscription')
          .insert(subscriptionData)
          .select('''
            *,
            subscription_plans (*)
          ''')
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to create user subscription: $e');
    }
  }

  static Future<dynamic> updateUserSubscription(Map<String, dynamic> subscriptionData) async {
    try {
      final response = await _supabase
          .from('user_subscription')
          .update(subscriptionData)
          .eq('user_id', _supabase.auth.currentUser!.id)
          .select('''
            *,
            subscription_plans (*)
          ''')
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update user subscription: $e');
    }
  }

  static Future<void> cancelUserSubscription() async {
    try {
      await _supabase
          .from('user_subscription')
          .update({
            'status': 'cancelled',
            'cancelled_at': DateTime.now().toIso8601String()
          })
          .eq('user_id', _supabase.auth.currentUser!.id);
    } catch (e) {
      throw Exception('Failed to cancel user subscription: $e');
    }
  }

  // ============ ADDRESSES ============
  static Future<List<dynamic>> getAddresses() async {
    try {
      final response = await _supabase
          .from('addresses')
          .select()
          .eq('user_id', _supabase.auth.currentUser!.id)
          .order('is_default', ascending: false)
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      throw Exception('Failed to load addresses: $e');
    }
  }

  static Future<dynamic> createAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await _supabase
          .from('addresses')
          .insert(addressData)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to create address: $e');
    }
  }

  static Future<dynamic> updateAddress(String addressId, Map<String, dynamic> addressData) async {
    try {
      final response = await _supabase
          .from('addresses')
          .update(addressData)
          .eq('id', addressId)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  static Future<void> deleteAddress(String addressId) async {
    try {
      await _supabase
          .from('addresses')
          .delete()
          .eq('id', addressId);
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  // ============ REAL-TIME SUBSCRIPTIONS (UPDATED) ============
  
  // Stream for orders real-time updates
  static Stream<List<Map<String, dynamic>>> getOrdersStream() {
    return _supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);
  }

  // Stream for menu items real-time updates
  static Stream<List<Map<String, dynamic>>> getMenuItemsStream() {
    return _supabase
        .from('menu_items')
        .stream(primaryKey: ['id'])
        .eq('is_available', true)
        .order('sort_order', ascending: true);
  }

  // Stream for user subscription updates
  static Stream<List<Map<String, dynamic>>> getUserSubscriptionStream() {
    return _supabase
        .from('user_subscription')
        .stream(primaryKey: ['id'])
        .eq('user_id', _supabase.auth.currentUser!.id);
  }

  // Stream for order status updates (specific order)
  static Stream<Map<String, dynamic>> getOrderStatusStream(String orderId) {
    return _supabase
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('id', orderId)
        .map((events) => events.isNotEmpty ? events.first : {});
  }

  // ============ AUTH METHODS ============
  static Future<AuthResponse> signUp(String email, String password, Map<String, dynamic> profile) async {
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        // Create profile
        await _supabase
            .from('profiles')
            .insert({
              'id': authResponse.user!.id,
              ...profile,
              'created_at': DateTime.now().toIso8601String(),
            });
      }

      return authResponse;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  static Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  static User? get currentUser => _supabase.auth.currentUser;

  // ============ UTILITY METHODS ============
  static Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      throw Exception('Failed to update password: $e');
    }
  }

  static Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }
}
