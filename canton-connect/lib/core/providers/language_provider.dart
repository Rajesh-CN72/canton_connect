import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en');
  
  // Return Locale for localization
  Locale get currentLocale => _currentLocale;
  
  // Return language code as string for convenience
  String get currentLanguage => _currentLocale.languageCode;
  
  // Method to change language - takes Locale object
  void setLanguage(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
  
  // Method to change language by string code
  void setLanguageByCode(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }
  
  // Helper getter for Chinese check
  bool get isChinese => _currentLocale.languageCode == 'zh';
  
  // Toggle between languages
  void toggleLanguage() {
    _currentLocale = _currentLocale.languageCode == 'en' 
        ? const Locale('zh') 
        : const Locale('en');
    notifyListeners();
  }
}
