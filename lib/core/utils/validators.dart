class Validators {
  Validators._();

  /// Required Field Validation
  static String? requiredField(
    String? value, {
    String fieldName = "This field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  /// Name Validation
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    if (value.trim().length < 2) {
      return "Name must contain at least 2 characters";
    }

    return null;
  }

  /// Phone Number Validation
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    final phone = value.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phone)) {
      return "Enter a valid 10-digit phone number";
    }

    return null;
  }

  /// Search Validation
  static String? search(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter something to search";
    }
    return null;
  }

  /// Number Validation
  static String? number(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Number is required";
    }

    if (double.tryParse(value) == null) {
      return "Enter a valid number";
    }

    return null;
  }

  /// Positive Number Validation
  static String? positiveNumber(String? value) {
    final result = number(value);

    if (result != null) return result;

    if (double.parse(value!) <= 0) {
      return "Number must be greater than zero";
    }

    return null;
  }

  /// Email Validation (for future use)
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }

    return null;
  }

  /// Password Validation (for future use)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }
}