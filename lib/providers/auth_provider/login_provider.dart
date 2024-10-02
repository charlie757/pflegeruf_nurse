import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/model/login_model.dart';
import 'package:nurse/screens/dashboard/dashboard_screen.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';

import '../../utils/constants.dart';
import '../../utils/location_service.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginModel;
   bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isKeepSigned = false;
  bool isVisiblePassword = true;

  /// to show the textfield error
  String? emailValidationMsg = '';
  String? passwordValidationMsg = '';

  clearValues() {
    emailController.clear();
    passwordController.clear();
    isKeepSigned = false;
    isVisiblePassword = true;
    isChecked=false;
  }

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  updateKeepSigned(value) {
    /// again update value when click on login button (if user changes the value after select the "keep me signed in")
    isKeepSigned = value;
    SessionManager.setKeepMySignedIn = value;
    SessionManager.setUserEmail = emailController.text;
    SessionManager.setuserPassword = passwordController.text;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  
  updateIsChecked(value) {
    isChecked = value;
    notifyListeners();
  }

  checkValidation() {
    if (AppValidation.emailValidator(emailController.text) == null &&
        AppValidation.passwordValidator(passwordController.text) == null) {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
 if (!isChecked) {
        Utils.errorSnackBar(
            'Accept terms & condition', navigatorKey.currentContext);
      }
      else{
        callApiFunction();
      }
    } else {
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg =
          AppValidation.passwordValidator(passwordController.text);
    }
    notifyListeners();
  }

  callApiFunction() {
    getLocationPermission().then((val){
      print('object$val');
      if(val=='deniedForever'){
        Geolocator.openAppSettings();
      }
      else if(val=='deniedPermission'){
        getLocationPermission();
      }
      else{
        Constants.is401Error=false;
        Utils.hideTextField();
        SessionManager.setUserEmail = emailController.text;
        SessionManager.setuserPassword = passwordController.text;
        updateLoading(true);
        notifyListeners();
        var data = {
          "username": emailController.text,
          "password": passwordController.text,
          "device": Platform.isIOS ? 'ios' : 'android',
          'latitude': SessionManager.lat,
          'longitude': SessionManager.lng,
          'fcm_key': SessionManager.fcmToken
        };
        String body = Uri(queryParameters: data).query;
        print(body);
        ApiService.apiMethod(
          url: ApiUrl.loginUrl,
          body: body,
          method: checkApiMethod(httpMethod.post),
        ).then((value) {
          updateLoading(false);
          if (value != null) {
            loginModel = LoginModel.fromJson(value);
            if (loginModel!.data != null && loginModel!.data!.status == true) {
              /// check account type
              if (loginModel!.data!.userDetails!.userAccountType == 2) {
                if (SessionManager.keepMySignedIn) {
                  updateIsVisiblePassword(true);
                }
                SessionManager.setToken = loginModel!.data!.token;
                AppRoutes.pushReplacementNavigation(const DashboardScreen(index: 0,));
              } else {
                Utils.errorSnackBar('User not found', navigatorKey.currentContext);
              }
            } else {
              Utils.errorSnackBar(loginModel!.message, navigatorKey.currentContext);
            }
          }
        });

      }
    });
    /// set the values
  }
}
