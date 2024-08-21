import 'package:get/get.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/utils/utils.dart';

class AppValidation {
  static String? firstNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterFirstName', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? lastNameValidator(val) {
    if (val.isEmpty) {
      return getTranslated('enterLastName', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? phoneNumberValidator(val) {
    if (val.isEmpty) {
      return getTranslated(
              'enterYourPhonenUmber', navigatorKey.currentContext!)!
          .tr;
    } else if (val.length < 10) {
      return getTranslated(
              'enteValidPhoneNumber', navigatorKey.currentContext!)!
          .tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? emailValidator(val) {
    RegExp regExp = RegExp(Utils.emailPattern.trim());
    if (val.isEmpty) {
      return getTranslated('enterYourEmail', navigatorKey.currentContext!)!.tr;
    } else if (!regExp.hasMatch(val)) {
      return getTranslated('enterValidEmail', navigatorKey.currentContext!)!.tr;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? passwordValidator(val) {
    // RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (val.isEmpty) {
      return getTranslated('enterYourPasword', navigatorKey.currentContext!)!
          .tr;
    }
    //  else if (!regExp.hasMatch(val)) {
    //   return 'Password should contain at least one upper case, one lower case, one digit, one Special character';
    // }
    else {
      return null;

      /// should be return "null" value here in else condition
    }
  }

  static String? reEnterpasswordValidator(currentValue, previousValue) {
    // RegExp regExp = RegExp(Utils.passwordPattern.trim());
    if (currentValue.isEmpty) {
      return getTranslated('enterYourPasword', navigatorKey.currentContext!)!
          .tr;
    }
    //  else if (!regExp.hasMatch(currentValue)) {
    //   return 'Password should contain at least one upper case, one lower case, one digit, one Special character';
    // }
    else if (previousValue.isNotEmpty) {
      if (currentValue != previousValue) {
        return getTranslated(
                'passwordShouldBeSame', navigatorKey.currentContext!)!
            .tr;
      }
      return null;
    } else {
      return null;

      /// should be return "null" value here in else condition
    }
  }
}
