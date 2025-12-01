import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:canton_connect/core/constants/app_colors.dart';
import 'package:canton_connect/core/constants/app_constants.dart';
import 'package:canton_connect/core/constants/app_strings.dart';

class Helpers {
  // ==============================
  // STRING FORMATTING
  // ==============================

  static String formatPrice(double price, {String? currencySymbol}) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol ?? AppStrings.currency,
      decimalDigits: 2,
    );
    return formatter.format(price);
  }

  static String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      return '${(distanceInKm * 1000).round()} m';
    }
    return '${distanceInKm.toStringAsFixed(1)} km';
  }

  static String formatTime(int minutes) {
    if (minutes < 60) {
      return '$minutes ${AppStrings.minutesAgo.replaceAll('minutes', 'min')}';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return remainingMinutes > 0 ? '$hours h $remainingMinutes min' : '$hours h';
    }
  }

  static String formatOrderNumber(int orderId) {
    return '#${orderId.toString().padLeft(6, '0')}';
  }

  static String formatRating(double rating) {
    return rating.toStringAsFixed(1);
  }

  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  static String capitalizeWords(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map(capitalize).join(' ');
  }

  static String truncateWithEllipsis(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // ==============================
  // DATE & TIME
  // ==============================

  static String formatDate(DateTime date, {String? language}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return language == 'zh' ? '今天' : AppStrings.today;
    } else if (dateOnly == yesterday) {
      return language == 'zh' ? '昨天' : AppStrings.yesterday;
    } else if (dateOnly.isAfter(today.subtract(const Duration(days: 7)))) {
      final daysAgo = today.difference(dateOnly).inDays;
      return language == 'zh' ? '$daysAgo天前' : '$daysAgo ${AppStrings.daysAgo}';
    } else {
      final format = language == 'zh' ? 'yyyy年MM月dd日' : 'MMM dd, yyyy';
      return DateFormat(format).format(date);
    }
  }

  static String formatDateTime(DateTime dateTime, {String? language}) {
    final dateFormat = language == 'zh' ? 'MM月dd日' : 'MMM dd';
    const timeFormat = 'HH:mm';
    
    return '${DateFormat(dateFormat).format(dateTime)} at ${DateFormat(timeFormat).format(dateTime)}';
  }

  static String formatTimeAgo(DateTime dateTime, {String? language}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return language == 'zh' ? '刚刚' : AppStrings.justNow;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return language == 'zh' ? '$minutes分钟前' : '$minutes ${AppStrings.minutesAgo}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return language == 'zh' ? '$hours小时前' : '$hours ${AppStrings.hoursAgo}';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return language == 'zh' ? '$days天前' : '$days ${AppStrings.daysAgo}';
    } else {
      return formatDate(dateTime, language: language);
    }
  }

  // ==============================
  // VALIDATION
  // ==============================

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    return phoneRegex.hasMatch(phone);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidChinesePhoneNumber(String phone) {
    final chinesePhoneRegex = RegExp(r'^1[3-9]\d{9}$');
    return chinesePhoneRegex.hasMatch(phone);
  }

  // ==============================
  // UI HELPERS
  // ==============================

  static Color getColorBasedOnRating(double rating) {
    if (rating >= 4.5) return AppColors.success;
    if (rating >= 3.5) return AppColors.warning;
    if (rating >= 2.5) return AppColors.rating;
    return AppColors.error;
  }

  static Color getColorBasedOnStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return AppColors.success;
      case 'preparing':
      case 'confirmed':
        return AppColors.info;
      case 'pending':
        return AppColors.warning;
      case 'cancelled':
      case 'failed':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  static String getOrderStatusText(String status, String language) {
    final statusMap = {
      'pending': language == 'zh' ? '待处理' : 'Pending',
      'confirmed': language == 'zh' ? '已确认' : 'Confirmed',
      'preparing': language == 'zh' ? '准备中' : 'Preparing',
      'ready': language == 'zh' ? '已就绪' : 'Ready',
      'out_for_delivery': language == 'zh' ? '配送中' : 'Out for Delivery',
      'delivered': language == 'zh' ? '已送达' : 'Delivered',
      'cancelled': language == 'zh' ? '已取消' : 'Cancelled',
    };
    return statusMap[status] ?? status;
  }

  static double calculateDiscountPercentage(double originalPrice, double discountedPrice) {
    if (originalPrice <= 0) return 0;
    return ((originalPrice - discountedPrice) / originalPrice * 100).roundToDouble();
  }

  static String formatNutritionValue(double value, String unit) {
    if (value == value.truncateToDouble()) {
      return '${value.toInt()}$unit';
    }
    return '${value.toStringAsFixed(1)}$unit';
  }

  // ==============================
  // CALCULATIONS
  // ==============================

  static double calculateTax(double subtotal, {double taxRate = 0.08}) {
    return (subtotal * taxRate);
  }

  static double calculateDeliveryFee(double subtotal, {double minimumForFreeDelivery = 25.0}) {
    if (subtotal >= minimumForFreeDelivery) {
      return 0.0;
    }
    return AppConstants.deliveryFee;
  }

  static double calculateTotalAmount(double subtotal, {double taxRate = 0.08}) {
    final tax = calculateTax(subtotal, taxRate: taxRate);
    final deliveryFee = calculateDeliveryFee(subtotal);
    return subtotal + tax + deliveryFee;
  }

  static int estimateDeliveryTime(int preparationTime, double distance) {
    // Base preparation time + travel time (assuming 5 minutes per km)
    final travelTime = (distance * 5).round();
    return preparationTime + travelTime;
  }

  // ==============================
  // FILE & ASSET HELPERS
  // ==============================

  static String getAssetPath(String fileName, {String type = 'images'}) {
    return 'assets/$type/$fileName';
  }

  static String getIconPath(String iconName) {
    return 'assets/icons/$iconName';
  }

  static bool isImageUrl(String url) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.bmp'];
    return imageExtensions.any((ext) => url.toLowerCase().contains(ext));
  }

  static bool isVideoUrl(String url) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.webm'];
    return videoExtensions.any((ext) => url.toLowerCase().contains(ext));
  }

  // ==============================
  // MISC HELPERS
  // ==============================

  static void showKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static String generateOrderId() {
    final now = DateTime.now();
    final random = now.millisecondsSinceEpoch % 10000;
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${random.toString().padLeft(4, '0')}';
  }

  static String getInitials(String name) {
    if (name.isEmpty) return '';
    final names = name.split(' ');
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();
  }

  static Color getRandomColor(String seed) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      AppColors.info,
      AppColors.success,
      AppColors.warning,
    ];
    final index = seed.hashCode % colors.length;
    return colors[index];
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }
}

// Extension for DateTime
extension DateTimeExtension on DateTime {
  String formatTimeAgo({String? language}) {
    return Helpers.formatTimeAgo(this, language: language);
  }

  String formatDate({String? language}) {
    return Helpers.formatDate(this, language: language);
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}

// Extension for String
extension StringExtension on String {
  String capitalize() {
    return Helpers.capitalize(this);
  }

  String capitalizeWords() {
    return Helpers.capitalizeWords(this);
  }

  String truncateWithEllipsis(int maxLength) {
    return Helpers.truncateWithEllipsis(this, maxLength);
  }

  bool get isValidEmail => Helpers.isValidEmail(this);
  bool get isValidPhone => Helpers.isValidPhoneNumber(this);
  bool get isValidPassword => Helpers.isValidPassword(this);
  bool get isValidChinesePhone => Helpers.isValidChinesePhoneNumber(this);
}

// Extension for double
extension DoubleExtension on double {
  String formatPrice({String? currencySymbol}) {
    return Helpers.formatPrice(this, currencySymbol: currencySymbol);
  }

  String formatRating() {
    return Helpers.formatRating(this);
  }

  Color get ratingColor {
    return Helpers.getColorBasedOnRating(this);
  }
}

// Extension for int
extension IntExtension on int {
  String formatTime() {
    return Helpers.formatTime(this);
  }

  String formatOrderNumber() {
    return Helpers.formatOrderNumber(this);
  }
}
