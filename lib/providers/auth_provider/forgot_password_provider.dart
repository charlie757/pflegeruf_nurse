import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/screens/auth/forgot_verification_screen.dart';
import 'package:nurse/utils/app_validation.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  bool isLoading = false;

  /// to show the textfield error
  String? emailValidationMsg = '';

  clearValues() {
    emailController.clear();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkValidation() {
    if (AppValidation.emailValidator(emailController.text) == null) {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      callApiFunction();
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
    }
    notifyListeners();
  }

  callApiFunction() {
    updateLoading(true);
    var data = {
      "username": emailController.text,
    };
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
      url: ApiUrl.forgotPasswordUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
    ).then((value) {
      updateLoading(false);
      if (value != null) {
        AppRoutes.pushCupertinoNavigation(ForgotVerificationScreen(
          email: emailController.text,
        ));
      }
    });
  }
}
