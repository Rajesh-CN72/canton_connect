import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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
      print('Error loading translation file: $e');
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
}
