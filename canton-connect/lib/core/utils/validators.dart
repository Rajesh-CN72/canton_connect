// lib/core/utils/validators.dart

class Validators {
  // ============ CORE VALIDATORS ============

  /// 🎯 Required field validation
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// 📏 Minimum length validation
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'This field'}) {
    if (value != null && value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  /// 📐 Maximum length validation
  static String? validateMaxLength(String? value, int maxLength, {String fieldName = 'This field'}) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }

  /// 🔢 Numeric validation
  static String? validateNumeric(String? value, {String fieldName = 'This field'}) {
    if (value != null && value.isNotEmpty) {
      final numericValue = num.tryParse(value);
      if (numericValue == null) {
        return '$fieldName must be a valid number';
      }
    }
    return null;
  }

  /// ➕ Positive number validation
  static String? validatePositiveNumber(String? value, {String fieldName = 'This field'}) {
    final numericError = validateNumeric(value, fieldName: fieldName);
    if (numericError != null) return numericError;

    if (value != null && value.isNotEmpty) {
      final numericValue = num.parse(value);
      if (numericValue <= 0) {
        return '$fieldName must be greater than 0';
      }
    }
    return null;
  }

  /// 🎭 Custom regex validation
  static String? validateRegex(
    String? value, 
    RegExp regex, 
    String errorMessage,
  ) {
    if (value != null && value.isNotEmpty && !regex.hasMatch(value)) {
      return errorMessage;
    }
    return null;
  }

  /// 🔄 Combine multiple validators
  static String? Function(String?) combineValidators(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  // ============ AUTH VALIDATORS ============

  /// 📧 Email validation
  static String? validateEmail(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Email'),
      (v) => validateMinLength(v, 3, fieldName: 'Email'),
      (v) => validateRegex(
        v,
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),
        'Please enter a valid email address',
      ),
    ])(value);
  }

  /// 🔐 Password validation
  static String? validatePassword(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Password'),
      (v) => validateMinLength(v, 6, fieldName: 'Password'),
    ])(value);
  }

  /// 🔒 Strong password validation
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final errors = <String>[];

    if (value.length < 8) {
      errors.add('at least 8 characters long');
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add('one uppercase letter');
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add('one lowercase letter');
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      errors.add('one number');
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      errors.add('one special character');
    }

    if (errors.isNotEmpty) {
      return 'Password must contain ${errors.join(', ')}';
    }

    return null;
  }

  /// 🔄 Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Confirm password'),
      (v) {
        if (v != null && v != password) {
          return 'Passwords do not match';
        }
        return null;
      },
    ])(value);
  }

  // ============ PROFILE VALIDATORS ============

  /// 👤 Name validation
  static String? validateName(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Name'),
      (v) => validateMinLength(v, 2, fieldName: 'Name'),
      (v) => validateMaxLength(v, 50, fieldName: 'Name'),
      (v) => validateRegex(
        v,
        RegExp(r"^[a-zA-Zà-ÿÀ-Ÿ '\-]+$"),
        'Name can only contain letters, spaces, hyphens, and apostrophes',
      ),
    ])(value);
  }

  /// 📞 Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone is optional
    }

    // International phone regex (supports +, spaces, hyphens, parentheses)
    final phoneRegex = RegExp(r'^[\+]?[0-9\s\-\(\)]{10,15}$');
    
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    // Remove all non-digit characters and check length
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    return null;
  }

  // ============ BUSINESS VALIDATORS ============

  /// 🏢 Business name validation
  static String? validateBusinessName(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Business name'),
      (v) => validateMinLength(v, 2, fieldName: 'Business name'),
      (v) => validateMaxLength(v, 100, fieldName: 'Business name'),
    ])(value);
  }

  /// 🏷️ Category validation
  static String? validateCategory(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Category'),
      (v) => validateMinLength(v, 2, fieldName: 'Category'),
      (v) => validateMaxLength(v, 50, fieldName: 'Category'),
    ])(value);
  }

  /// 📝 Description validation
  static String? validateDescription(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Description'),
      (v) => validateMinLength(v, 10, fieldName: 'Description'),
      (v) => validateMaxLength(v, 500, fieldName: 'Description'),
    ])(value);
  }

  // ============ ADDRESS VALIDATORS ============

  /// 📍 Address validation
  static String? validateAddress(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Address'),
      (v) => validateMinLength(v, 5, fieldName: 'Address'),
      (v) => validateMaxLength(v, 200, fieldName: 'Address'),
    ])(value);
  }

  /// 🏙️ City validation
  static String? validateCity(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'City'),
      (v) => validateMinLength(v, 2, fieldName: 'City'),
      (v) => validateMaxLength(v, 50, fieldName: 'City'),
    ])(value);
  }

  /// 📮 ZIP code validation (US format)
  static String? validateZipCode(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'ZIP code'),
      (v) => validateRegex(
        v,
        RegExp(r'^\d{5}(-\d{4})?$'),
        'Please enter a valid ZIP code (XXXXX or XXXXX-XXXX)',
      ),
    ])(value);
  }

  // ============ PRODUCT/VALIDATORS ============

  /// 💰 Price validation
  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }

    // Remove currency symbols and commas
    final cleanValue = value.replaceAll(RegExp(r'[^\d.]'), '');
    
    final price = double.tryParse(cleanValue);
    if (price == null) {
      return 'Please enter a valid price';
    }

    if (price <= 0) {
      return 'Price must be greater than 0';
    }

    if (price > 99999.99) {
      return 'Price must be less than \$100,000';
    }

    return null;
  }

  /// 🔢 Quantity validation
  static String? validateQuantity(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Quantity'),
      (v) => validateNumeric(v, fieldName: 'Quantity'),
      (v) => validatePositiveNumber(v, fieldName: 'Quantity'),
      (v) {
        if (v != null && v.isNotEmpty) {
          final quantity = int.parse(v);
          if (quantity > 999) {
            return 'Quantity must be less than 1000';
          }
        }
        return null;
      },
    ])(value);
  }

  /// ⏱️ Preparation time validation (in minutes)
  static String? validatePreparationTime(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Preparation time'),
      (v) => validateNumeric(v, fieldName: 'Preparation time'),
      (v) => validatePositiveNumber(v, fieldName: 'Preparation time'),
      (v) {
        if (v != null && v.isNotEmpty) {
          final time = int.parse(v);
          if (time > 480) { // 8 hours max
            return 'Preparation time must be less than 8 hours';
          }
        }
        return null;
      },
    ])(value);
  }

  // ============ PAYMENT VALIDATORS ============

  /// 💳 Credit card number validation
  static String? validateCreditCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    // Basic credit card number validation
    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
      return 'Please enter a valid credit card number';
    }

    // Luhn algorithm validation
    if (!_isValidLuhn(digitsOnly)) {
      return 'Please enter a valid credit card number';
    }

    return null;
  }

  /// 📆 Expiry date validation (MM/YY format)
  static String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    // MM/YY format
    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!expiryRegex.hasMatch(value)) {
      return 'Please enter a valid expiry date (MM/YY)';
    }

    // Check if card is expired
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0); // Last day of expiry month

    if (expiryDate.isBefore(now)) {
      return 'This card has expired';
    }

    return null;
  }

  /// 🔢 CVV validation
  static String? validateCVV(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'CVV'),
      (v) => validateRegex(
        v,
        RegExp(r'^[0-9]{3,4}$'),
        'Please enter a valid CVV (3 or 4 digits)',
      ),
    ])(value);
  }

  // ============ ADMIN VALIDATORS ============

  /// 🔑 Invitation code validation
  static String? validateInvitationCode(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Invitation code'),
      (v) => validateMinLength(v, 6, fieldName: 'Invitation code'),
      (v) => validateMaxLength(v, 20, fieldName: 'Invitation code'),
    ])(value);
  }

  /// 📧 Admin email validation (same as regular email)
  static String? validateAdminEmail(String? value) {
    return validateEmail(value);
  }

  // ============ UTILITY VALIDATORS ============

  /// 🌐 URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    final urlRegex = RegExp(
      r'^(https?://)?([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?$',
      caseSensitive: false,
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// 📅 Date validation (YYYY-MM-DD format)
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    try {
      DateTime.parse(value);
    } catch (e) {
      return 'Please enter a valid date (YYYY-MM-DD)';
    }

    return null;
  }

  /// 🎂 Age validation (must be 18+)
  static String? validateAge(String? value) {
    final dateError = validateDate(value);
    if (dateError != null) return dateError;

    try {
      final birthDate = DateTime.parse(value!);
      final now = DateTime.now();
      final age = now.year - birthDate.year;

      // Adjust age if birthday hasn't occurred this year
      final hasBirthdayPassed = now.month > birthDate.month || 
          (now.month == birthDate.month && now.day >= birthDate.day);

      final actualAge = hasBirthdayPassed ? age : age - 1;

      if (actualAge < 18) {
        return 'You must be at least 18 years old';
      }
    } catch (e) {
      return 'Please enter a valid date of birth';
    }

    return null;
  }

  /// 🔢 OTP validation (6-digit code)
  static String? validateOTP(String? value) {
    return combineValidators([
      (v) => validateRequired(v, fieldName: 'Verification code'),
      (v) => validateRegex(
        v,
        RegExp(r'^[0-9]{6}$'),
        'Please enter a valid 6-digit code',
      ),
    ])(value);
  }

  // ============ PRIVATE HELPER METHODS ============

  /// Luhn algorithm for credit card validation
  static bool _isValidLuhn(String cardNumber) {
    final digits = cardNumber.split('').map(int.parse).toList();
    var sum = 0;
    var isEven = false;

    for (var i = digits.length - 1; i >= 0; i--) {
      var digit = digits[i];

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }
}

// ============ EXTENSIONS FOR EASIER USAGE ============

extension ValidatorExtensions on String? {
  String? validateRequired({String fieldName = 'This field'}) {
    return Validators.validateRequired(this, fieldName: fieldName);
  }

  String? validateEmail() => Validators.validateEmail(this);
  
  String? validatePassword() => Validators.validatePassword(this);
  
  String? validateStrongPassword() => Validators.validateStrongPassword(this);
  
  String? validateName() => Validators.validateName(this);
  
  String? validatePhone() => Validators.validatePhone(this);
  
  String? validateMinLength(int minLength, {String fieldName = 'This field'}) {
    return Validators.validateMinLength(this, minLength, fieldName: fieldName);
  }

  String? validateMaxLength(int maxLength, {String fieldName = 'This field'}) {
    return Validators.validateMaxLength(this, maxLength, fieldName: fieldName);
  }

  String? validateNumeric({String fieldName = 'This field'}) {
    return Validators.validateNumeric(this, fieldName: fieldName);
  }

  String? validatePositiveNumber({String fieldName = 'This field'}) {
    return Validators.validatePositiveNumber(this, fieldName: fieldName);
  }

  String? validateConfirmPassword(String password) {
    return Validators.validateConfirmPassword(this, password);
  }
}

// ============ ADVANCED VALIDATION CLASSES ============

/// 🏷️ Validation result for complex scenarios
class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final Map<String, dynamic>? additionalData;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.additionalData,
  });

  factory ValidationResult.valid() => const ValidationResult(isValid: true);
  
  factory ValidationResult.invalid(String message, {Map<String, dynamic>? data}) =>
      ValidationResult(isValid: false, errorMessage: message, additionalData: data);
}

/// 🚀 Advanced validator for complex scenarios
class AdvancedValidator {
  /// Validate food item for admin panel
  static ValidationResult validateFoodItem({
    required String name,
    required String description,
    required String price,
    required String preparationTime,
    String? imageUrl,
    required String category,
  }) {
    final errors = <String, String>{};

    // Validate name
    final nameError = Validators.validateName(name);
    if (nameError != null) errors['name'] = nameError;

    // Validate description
    final descError = Validators.validateDescription(description);
    if (descError != null) errors['description'] = descError;

    // Validate price
    final priceError = Validators.validatePrice(price);
    if (priceError != null) errors['price'] = priceError;

    // Validate preparation time
    final timeError = Validators.validatePreparationTime(preparationTime);
    if (timeError != null) errors['preparationTime'] = timeError;

    // Validate category
    final categoryError = Validators.validateCategory(category);
    if (categoryError != null) errors['category'] = categoryError;

    // Validate image URL (optional)
    if (imageUrl != null && imageUrl.isNotEmpty) {
      final urlError = Validators.validateUrl(imageUrl);
      if (urlError != null) errors['imageUrl'] = urlError;
    }

    if (errors.isEmpty) {
      return ValidationResult.valid();
    } else {
      return ValidationResult.invalid(
        'Please fix the errors below',
        data: {'fieldErrors': errors},
      );
    }
  }

  /// Validate address form
  static ValidationResult validateAddressForm({
    required String fullName,
    required String phone,
    required String street,
    required String city,
    required String zipCode,
    String? state,
    String? country,
  }) {
    final errors = <String, String>{};

    // Validate full name
    final nameError = Validators.validateName(fullName);
    if (nameError != null) errors['fullName'] = nameError;

    // Validate phone
    final phoneError = Validators.validatePhone(phone);
    if (phoneError != null) errors['phone'] = phoneError;

    // Validate street address
    final streetError = Validators.validateAddress(street);
    if (streetError != null) errors['street'] = streetError;

    // Validate city
    final cityError = Validators.validateCity(city);
    if (cityError != null) errors['city'] = cityError;

    // Validate ZIP code
    final zipError = Validators.validateZipCode(zipCode);
    if (zipError != null) errors['zipCode'] = zipError;

    if (errors.isEmpty) {
      return ValidationResult.valid();
    } else {
      return ValidationResult.invalid(
        'Please fix the address errors',
        data: {'fieldErrors': errors},
      );
    }
  }

  /// Validate user registration form
  static ValidationResult validateUserRegistration({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
    String? phone,
  }) {
    final errors = <String, String>{};

    // Validate email
    final emailError = Validators.validateEmail(email);
    if (emailError != null) errors['email'] = emailError;

    // Validate password
    final passwordError = Validators.validatePassword(password);
    if (passwordError != null) errors['password'] = passwordError;

    // Validate confirm password
    final confirmError = Validators.validateConfirmPassword(confirmPassword, password);
    if (confirmError != null) errors['confirmPassword'] = confirmError;

    // Validate full name
    final nameError = Validators.validateName(fullName);
    if (nameError != null) errors['fullName'] = nameError;

    // Validate phone (optional)
    if (phone != null && phone.isNotEmpty) {
      final phoneError = Validators.validatePhone(phone);
      if (phoneError != null) errors['phone'] = phoneError;
    }

    if (errors.isEmpty) {
      return ValidationResult.valid();
    } else {
      return ValidationResult.invalid(
        'Please fix the registration errors',
        data: {'fieldErrors': errors},
      );
    }
  }
}

// ============ VALIDATOR CONSTANTS ============

class ValidatorConstants {
  // Common field names
  static const String email = 'Email';
  static const String password = 'Password';
  static const String name = 'Name';
  static const String phone = 'Phone number';
  static const String address = 'Address';
  static const String city = 'City';
  static const String zipCode = 'ZIP code';
  static const String price = 'Price';
  static const String quantity = 'Quantity';
  static const String description = 'Description';
  static const String category = 'Category';

  // Common validation messages
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String weakPassword = 'Password is too weak';
  static const String passwordMismatch = 'Passwords do not match';
  static const String invalidPhone = 'Please enter a valid phone number';
  static const String invalidUrl = 'Please enter a valid URL';
  static const String invalidDate = 'Please enter a valid date';
  static const String underAge = 'You must be at least 18 years old';
}
