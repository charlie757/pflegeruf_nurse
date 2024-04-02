import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/profile_model.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? profileModel;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisiblePassword = true;
  File? imgFile;

  /// to show the textfield error
  String? firstNamevalidationMsg = '';
  String? lastNamevalidationMsg = '';
  String? emailValidationMsg = '';
  String? phoneValidationMsg = '';
  String? passwordValidationMsg = '';
  String? reEnterPasswordValidationMsg = '';

  clearValues() {
    firstNamevalidationMsg = '';
    lastNamevalidationMsg = '';
    emailValidationMsg = '';
    phoneValidationMsg = '';
    passwordValidationMsg = '';
    reEnterPasswordValidationMsg = '';
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    isVisiblePassword = true;
  }

  updateIsVisiblePassword(value) {
    isVisiblePassword = value;
    notifyListeners();
  }

  checkValidation() {
    print('object');
    if (firstNamevalidationMsg == null &&
        lastNamevalidationMsg == null &&
        phoneValidationMsg == null &&
        emailValidationMsg == null &&
        passwordValidationMsg == null) {
      print('if');
      updateProfileApiFunction();
      // callApiFunction(route);
    } else {
      print('else');
      firstNamevalidationMsg =
          AppValidation.firstNameValidator(firstNameController.text);
      lastNamevalidationMsg =
          AppValidation.lastNameValidator(lastNameController.text);
      phoneValidationMsg =
          AppValidation.phoneNumberValidator(phoneController.text);
      emailValidationMsg = AppValidation.emailValidator(emailController.text);
      passwordValidationMsg = AppValidation.reEnterpasswordValidator(
          passwordController.text, passwordController.text);
    }
    notifyListeners();
  }

  getProfileApiFunction(bool showLoading) {
    ///calling in dashboard
    showLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.profileDetailsUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      showLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        profileModel = ProfileModel.fromJson(value);
        setControllersValues();
        notifyListeners();
      }
    });
  }

  setControllersValues() {
    if (profileModel != null &&
        profileModel!.data != null &&
        profileModel!.data!.details != null) {
      firstNameController.text = profileModel!.data!.details!.firstName;
      lastNameController.text = profileModel!.data!.details!.lastName;
      emailController.text = profileModel!.data!.details!.email;
      phoneController.text =
          profileModel!.data!.details!.mobileNumber.toString();
    }
  }

  updateProfileApiFunction() {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {
      'p_user_name': firstNameController.text,
      'p_user_surname': lastNameController.text,
      'p_user_mobile': phoneController.text,
      'latitude': SessionManager.lat,
      'longitude': SessionManager.lng
    };
    print(data);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.profileUpdateUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      isErrorMessageShow: true,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        getProfileApiFunction(false);
        Utils.successSnackBar(value['status'], navigatorKey.currentContext!);
        notifyListeners();
      }
    });
  }

  deleteAccountApiFunction() async {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {'': ''};
    print(data);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.deleteAccountUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      isErrorMessageShow: false,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.logOut();
        notifyListeners();
      }
    });
  }

  uploadProfileImageApiFunction() async {
    List<int> imageBytes = imgFile!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    showCircleProgressDialog(navigatorKey.currentContext!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${SessionManager.token}"
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.profilePhotoUrl));
    request.headers.addAll(headers);
    request.fields['photo_base64'] = base64Image;
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    log(vb.body);
    if (vb.statusCode == 200) {
      Navigator.pop(navigatorKey.currentContext!);
      var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      getProfileApiFunction(true);
    } else {
      Navigator.pop(navigatorKey.currentContext!);

      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
  }

  imagePicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: source, // alternatively, use ImageSource.gallery
    );
    if (img == null) return;

    imgFile = File(img.path); // convert it to a Dart:io file
    uploadProfileImageApiFunction();
    notifyListeners();
  }
}
