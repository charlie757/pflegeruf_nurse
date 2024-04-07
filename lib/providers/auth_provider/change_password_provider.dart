import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/screens/auth/login_screen.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/utils.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final enterNewPassword = TextEditingController();
  final reEnterNewPassword = TextEditingController();
  bool isVisibleNewPassword = false;
  bool isVisibleReEnterPassword = false;
  bool isLoading = false;

  String? passwordValidationMsg = '';
  String? reEnterPasswordValidationMsg = '';

  clearValues() {
    enterNewPassword.clear();
    reEnterNewPassword.clear();
    isVisibleNewPassword = false;
    isVisibleReEnterPassword = false;
  }

  updateIsVisibleNewPassword(value) {
    isVisibleNewPassword = value;
    notifyListeners();
  }

  updateIsVisibleReEnterPassword(value) {
    isVisibleReEnterPassword = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation(String email, String code) {
    if (AppValidation.reEnterpasswordValidator(
                enterNewPassword.text, reEnterNewPassword.text) ==
            null &&
        AppValidation.reEnterpasswordValidator(
                reEnterNewPassword.text, enterNewPassword.text) ==
            null) {
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          enterNewPassword.text, reEnterNewPassword.text);
      reEnterPasswordValidationMsg = AppValidation.reEnterpasswordValidator(
          reEnterNewPassword.text, enterNewPassword.text);
      callApiFunction(email, code);
    } else {
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          enterNewPassword.text, reEnterNewPassword.text);
      reEnterPasswordValidationMsg = AppValidation.reEnterpasswordValidator(
          reEnterNewPassword.text, enterNewPassword.text);
    }
    notifyListeners();
  }

  callApiFunction(String email, String code) {
    Utils.hideTextField();
    updateLoading(true);
    var data = {
      "username": email,
      "verification_code": code,
      "new_password": reEnterNewPassword.text,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.setNewPasswordUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        AppRoutes.pushReplacementNavigation(const LoginScreen());
      }
    });
  }
}
