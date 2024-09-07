// Project imports:


import 'package:doctor_book/common/utils/text_constants.dart';

class ValidatonFunction {
  static bool isFiledEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  static String? validateEmail(String? value) {
    if (isFiledEmpty(value)) {
      return TextConstant.inputEmpty;
    } else if (!TextConstant.validateEmail.hasMatch(value!)) {
      return TextConstant.emailError;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (isFiledEmpty(value)) {
      return TextConstant.inputEmpty;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (isFiledEmpty(value)) {
      return TextConstant.inputEmpty;
    } else if (value!.length < 6) {
      return TextConstant.passwordError;
    } 
    return null;
  }
    static String? validatePassword1(String? value, String? password) {
     if (value != password) {
      return TextConstant.passwordError2;
    } 
    return null;
  }
}
