// lib/presentation/providers/language_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool _isChinese = false;
  static const String _languageKey = 'app_language';

  LanguageProvider() {
    _loadLanguagePreference();
  }

  bool get isChinese => _isChinese;
  String get currentLanguage => _isChinese ? 'zh' : 'en';

  // ADD THIS MISSING METHOD
  Future<void> setLanguage(bool isChinese) async {
    if (_isChinese == isChinese) return;
    
    _isChinese = isChinese;
    
    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_languageKey, _isChinese);
    
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _isChinese = !_isChinese;
    
    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_languageKey, _isChinese);
    
    notifyListeners();
  }

  Future<void> _loadLanguagePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getBool(_languageKey);
      
      if (savedLanguage != null) {
        _isChinese = savedLanguage;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading language preference: $e');
      }
    }
  }
}
