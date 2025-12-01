import 'package:flutter/foundation.dart';

enum ThemeMode { light, dark, system }

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _useDynamicColor = true;
  double _fontScale = 1.0;

  ThemeMode get themeMode => _themeMode;
  bool get useDynamicColor => _useDynamicColor;
  double get fontScale => _fontScale;

  // Check if dark mode is enabled
  bool get isDarkMode {
    switch (_themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        // This would typically check the system brightness
        // For now, we'll default to light
        return false;
    }
  }

  // Set theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      _themeMode = ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  // Set dynamic color preference
  void setUseDynamicColor(bool useDynamic) {
    _useDynamicColor = useDynamic;
    notifyListeners();
  }

  // Set font scale
  void setFontScale(double scale) {
    _fontScale = scale.clamp(0.8, 2.0); // Limit between 0.8x and 2.0x
    notifyListeners();
  }

  // Reset to default settings
  void resetToDefaults() {
    _themeMode = ThemeMode.system;
    _useDynamicColor = true;
    _fontScale = 1.0;
    notifyListeners();
  }

  // Get theme mode as string
  String get themeModeString {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  // Set theme mode from string
  void setThemeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'system':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  // Check if system theme mode is being used
  bool get isUsingSystemTheme => _themeMode == ThemeMode.system;

  // Get theme description for UI
  String get themeDescription {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light Theme';
      case ThemeMode.dark:
        return 'Dark Theme';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  // Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeModeString,
      'useDynamicColor': _useDynamicColor,
      'fontScale': _fontScale,
    };
  }

  // Load from JSON
  void loadFromJson(Map<String, dynamic> json) {
    setThemeModeFromString(json['themeMode'] ?? 'system');
    _useDynamicColor = json['useDynamicColor'] ?? true;
    _fontScale = (json['fontScale'] ?? 1.0).toDouble();
    notifyListeners();
  }
}
