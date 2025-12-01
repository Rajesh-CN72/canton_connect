import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Chinese Text Styles
  static TextStyle chineseBold(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'NotoSansSC',
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  static TextStyle chineseMedium(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'NotoSansSC',
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  static TextStyle chineseRegular(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'NotoSansSC',
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  // English Text Styles
  static TextStyle englishBold(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  static TextStyle englishMedium(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  static TextStyle englishRegular(double fontSize, {Color? color}) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color ?? AppColors.textPrimary,
    );
  }
  
  // Common Text Styles
  static TextStyle get headlineLarge => englishBold(32);
  static TextStyle get headlineMedium => englishBold(24);
  static TextStyle get headlineSmall => englishBold(20);
  
  static TextStyle get titleLarge => englishMedium(18);
  static TextStyle get titleMedium => englishMedium(16);
  static TextStyle get titleSmall => englishMedium(14);
  
  static TextStyle get bodyLarge => englishRegular(16);
  static TextStyle get bodyMedium => englishRegular(14);
  static TextStyle get bodySmall => englishRegular(12);
  
  static TextStyle get button => englishMedium(16);
  
  // Chinese Specific Styles
  static TextStyle get chineseHeadlineLarge => chineseBold(32);
  static TextStyle get chineseBodyLarge => chineseRegular(16);
}
