import 'package:flutter/material.dart';

import 'helpers/sql_helper.dart';

class Validator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Enter correct email';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be as least 8 characters';
    }
    return null;
  }

  static String? confirmPasswordValidator(
      String? value, TextEditingController passwordController) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  static String? CheckCurrentPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    } else if (value != SQLAccountHelper.currentAccount['password']) {
      return 'Password does not match';
    }
    return null;
  }

  static nameValidator(String? value) {}
}
