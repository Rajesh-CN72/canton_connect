// lib/core/providers/currency_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class CurrencyProvider with ChangeNotifier {
  PriceDisplayStyle _currentStyle = PriceDisplayStyle.symbolOnly;
  static const String _currencyStyleKey = 'currency_style';
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CurrencyProvider() {
    _loadCurrencyStyle();
  }

  PriceDisplayStyle get currentStyle => _currentStyle;

  // Get the current currency symbol for quick access
  String get currentSymbol {
    switch (_currentStyle) {
      case PriceDisplayStyle.symbolOnly:
      case PriceDisplayStyle.symbolWithCode:
      case PriceDisplayStyle.compactSymbol:
        return AppConstants.currencySymbol;
      case PriceDisplayStyle.yuanOnly:
      case PriceDisplayStyle.yuanWithName:
      case PriceDisplayStyle.compactYuan:
        return AppConstants.currencySymbolChinese;
    }
  }

  // Format price using current style
  String formatPrice(double price) {
    try {
      return AppConstants.formatPriceWithStyle(price, _currentStyle);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error formatting price: $e');
      }
      return '${AppConstants.currencySymbol}${price.toStringAsFixed(2)}';
    }
  }

  // Change currency style and persist it
  Future<void> setCurrencyStyle(PriceDisplayStyle newStyle) async {
    if (_currentStyle == newStyle) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      _currentStyle = newStyle;
      
      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_currencyStyleKey, newStyle.index);
      
      // Notify all listeners to rebuild
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error saving currency style: $e');
      }
      // Revert on error
      _currentStyle = _currentStyle;
      notifyListeners();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load currency style from shared preferences
  Future<void> _loadCurrencyStyle() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedIndex = prefs.getInt(_currencyStyleKey);
      
      if (savedIndex != null && savedIndex < PriceDisplayStyle.values.length) {
        _currentStyle = PriceDisplayStyle.values[savedIndex];
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error loading currency style: $e');
      }
      // Continue with default style
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Quick toggle between Chinese and Symbol styles
  Future<void> toggleCurrencyStyle() async {
    final isChineseStyle = _currentStyle == PriceDisplayStyle.yuanOnly ||
                          _currentStyle == PriceDisplayStyle.yuanWithName ||
                          _currentStyle == PriceDisplayStyle.compactYuan;
    
    if (isChineseStyle) {
      await setCurrencyStyle(PriceDisplayStyle.symbolOnly);
    } else {
      await setCurrencyStyle(PriceDisplayStyle.yuanOnly);
    }
  }

  // Check if current style is Chinese format
  bool get isChineseFormat {
    return _currentStyle == PriceDisplayStyle.yuanOnly ||
           _currentStyle == PriceDisplayStyle.yuanWithName ||
           _currentStyle == PriceDisplayStyle.compactYuan;
  }

  // Check if current style is Symbol format
  bool get isSymbolFormat {
    return _currentStyle == PriceDisplayStyle.symbolOnly ||
           _currentStyle == PriceDisplayStyle.symbolWithCode ||
           _currentStyle == PriceDisplayStyle.compactSymbol;
  }

  // Get user-friendly name for current style
  String get currentStyleName {
    return AppConstants.getStyleName(_currentStyle);
  }

  // Get user-friendly name in Chinese for current style
  String get currentStyleNameChinese {
    return AppConstants.getStyleNameChinese(_currentStyle);
  }

  // Get all available styles
  List<PriceDisplayStyle> get availableStyles => AppConstants.allStyles;

  // Reset to default style
  Future<void> resetToDefault() async {
    await setCurrencyStyle(PriceDisplayStyle.symbolOnly);
  }
}
