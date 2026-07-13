import 'package:flutter/material.dart';

class Helpers {
  Helpers._();

  /// Show SnackBar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Hide Keyboard
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Format Phone Number
  static String formatPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'\s+'), '');
  }

  /// Check Empty String
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Capitalize First Letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1);
  }

  /// Convert bool to Yes/No
  static String boolToYesNo(bool value) {
    return value ? "Yes" : "No";
  }

  /// Convert bool to Available/Unavailable
  static String availability(bool value) {
    return value ? "Available" : "Unavailable";
  }

  /// Delay
  static Future<void> delay({
    int milliseconds = 500,
  }) async {
    await Future.delayed(
      Duration(milliseconds: milliseconds),
    );
  }
}