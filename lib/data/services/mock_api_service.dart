// Mock API service to replace Supabase
class MockApiService {
  static final MockApiService _instance = MockApiService._internal();
  factory MockApiService() => _instance;
  MockApiService._internal();

  // Mock user data
  final Map<String, dynamic> _mockUser = {
    'id': '1',
    'email': 'test@example.com',
    'name': 'Test User',
  };

  // Mock authentication methods
  Future<Map<String, dynamic>> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    
    if (email == 'test@example.com' && password == 'password') {
      return {'user': _mockUser, 'error': null};
    } else {
      return {'user': null, 'error': 'Invalid credentials'};
    }
  }

  Future<Map<String, dynamic>> signUpWithEmailAndPassword(String email, String password, Map<String, dynamic> userData) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return {
      'user': {..._mockUser, 'email': email, ...userData},
      'error': null
    };
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> resetPasswordForEmail(String email) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  // Mock data methods
  Future<List<Map<String, dynamic>>> getFoodItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUser;
  }
}

// Mock classes to replace Supabase types
class User {
  final String id;
  final String? email;

  User({required this.id, this.email});
}

class AuthResponse {
  final User? user;
  final String? error;

  AuthResponse({this.user, this.error});
}
