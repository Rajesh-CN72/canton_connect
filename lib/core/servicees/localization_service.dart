import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LocalizationService {
  LocalizationService(this.locale);
  
  final Locale locale;
  static Map<String, String> _localizedStrings = {};

  static Future<LocalizationService> load(Locale locale) async {
    LocalizationService localizationService = LocalizationService(locale);
    
    try {
      String jsonString = await rootBundle.loadString(
        'assets/translations/${locale.languageCode}.json',
      );
      
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      
      _localizedStrings = _flattenMap(jsonMap);
      
      return localizationService;
    } catch (e) {
      // FIXED: Replaced print with debugPrint for production-safe logging
      debugPrint('Error loading translation file for ${locale.languageCode}: $e');
      // Fallback to English
      return await load(const Locale('en'));
    }
  }

  static Map<String, String> _flattenMap(Map<String, dynamic> map, {String prefix = ''}) {
    final Map<String, String> result = {};
    
    map.forEach((key, value) {
      final newKey = prefix.isEmpty ? key : '$prefix.$key';
      
      if (value is Map<String, dynamic>) {
        result.addAll(_flattenMap(value, prefix: newKey));
      } else if (value is String) {
        result[newKey] = value;
      }
    });
    
    return result;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static const supportedLocales = [
    Locale('en'),
    Locale('zh'),
  ];

  static const fallbackLocale = Locale('en');

  // Additional helper methods for better localization support
  static bool isSupported(Locale locale) {
    return supportedLocales.any((supported) => supported.languageCode == locale.languageCode);
  }

  static Locale resolveLocale(Locale? locale) {
    if (locale == null) return fallbackLocale;
    
    // Check if exact locale is supported
    if (isSupported(locale)) {
      return locale;
    }
    
    // Check language code only (without country code)
    final languageOnly = Locale(locale.languageCode);
    if (isSupported(languageOnly)) {
      return languageOnly;
    }
    
    // Fallback to default
    return fallbackLocale;
  }

  // Get current language code
  String get currentLanguage => locale.languageCode;

  // Check if current language is Chinese
  bool get isChinese => currentLanguage == 'zh';

  // Check if current language is English
  bool get isEnglish => currentLanguage == 'en';

  // Get display name of current language
  String get languageName {
    switch (currentLanguage) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      default:
        return 'English';
    }
  }

  // Method to get all supported language names with their codes
  static Map<String, String> get supportedLanguageNames {
    return {
      'en': 'English',
      'zh': '中文',
    };
  }
}

// Extension for easier access in widgets
extension LocalizationExtension on BuildContext {
  LocalizationService get localization {
    return Localizations.of<LocalizationService>(this, LocalizationService)!;
  }

  String translate(String key) {
    return localization.translate(key);
  }

  bool get isChinese => localization.isChinese;
  bool get isEnglish => localization.isEnglish;
  String get currentLanguage => localization.currentLanguage;
}

// Custom LocalizationsDelegate
class AppLocalizationsDelegate extends LocalizationsDelegate<LocalizationService> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LocalizationService.supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  @override
  Future<LocalizationService> load(Locale locale) {
    return LocalizationService.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
