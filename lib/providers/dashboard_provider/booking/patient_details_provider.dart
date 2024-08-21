import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/patient_booking_model.dart';
import 'package:nurse/model/review_model.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  PatientBookingModel? model;
  ReviewModel? reviewModel;
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  String documentName = '';
  String documentPath = '';

  resetValues() {
    documentName = '';
    documentPath = '';
    commentController.clear();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  checkEndBookingValidation(String bookingId) async {
    if (formKey.currentState!.validate()) {
      Navigator.pop(navigatorKey.currentContext!);
      updateNurseDocApiFunction(bookingId);
    }
  }

  getBookingApiFunction(String id, bool isLoading) async {
    print("id....$id");
    if (isLoading) {
      model = null;
    }
    updateLoading(
        isLoading); // to handle the no data widget in case of any error
    showCircleProgressDialog(navigatorKey.currentContext!);
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.bookingDetails, body: map, isErrorMessageShow: true)
        .then((value) {
      updateLoading(false);
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        print('value..$value');
        model = PatientBookingModel.fromJson(value);
        // notifyListeners();
      }
    });
  }

  completeBookingApiFunction(String id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.bookingCompleteUrl, body: map, isErrorMessageShow: true)
        .then((value) {
      updateLoading(false);
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        getBookingApiFunction(id, false);
        // notifyListeners();
      }
    });
  }

  getRatingApiFunction(String id) {
    reviewModel = null;
    notifyListeners();
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.ratingUrl, body: map, isErrorMessageShow: true)
        .then((value) {
      updateLoading(false);
      if (value != null) {
        reviewModel = ReviewModel.fromJson(value);
        notifyListeners();
        // Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        // notifyListeners();
      }
    });
  }

  updateNurseDocApiFunction(bookingId) async {
    print('object');
    showCircleProgressDialog(navigatorKey.currentContext!);
    Map<String, String> headers = {
      "Authorization": "Bearer ${SessionManager.token}"
    };
print(SessionManager.token);
print(bookingId);
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrl.updateNurseDocUrl));
    request.headers.addAll(headers);
    if (documentPath.isNotEmpty) {
      final file = await http.MultipartFile.fromPath('nurse_doc', documentPath);
      request.files.add(file);
    }
    request.fields['message'] = commentController.text;
    request.fields['booking_id'] = bookingId;
    var res = await request.send();
    var vb = await http.Response.fromStream(res);
    Navigator.pop(navigatorKey.currentContext!);
    print(vb.request);
    log(vb.body);
    print(vb.statusCode);
    if (vb.statusCode == 200) {
      print('dsfdfsgsd');
      var dataAll = json.decode(vb.body);
      Utils.successSnackBar(dataAll['message'], navigatorKey.currentContext!);
      completeBookingApiFunction(bookingId);
    } else {
      var dataAll = json.decode(vb.body);
      Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext!);
    }
  }

  documentPicker(state) async {
    await Permission.storage.request();
    // if (await Permission.storage.request().isGranted) {
      print('vdfdsvdf');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: [
          'pdf',
        ],
      );
      if(result!=null) {
        PlatformFile file = result!.files.first;
        print(file.extension);
        if (file.extension == 'pdf') {
          final checkSize =
          checkFileSize(result!.files.first.path, navigatorKey.currentContext!);
          if (checkSize == true) {
            documentName = result.files.first.name;
            documentPath = result.files.first.path.toString();
            notifyListeners();
          }
        }
        else {
          EasyLoading.showToast('Unsupported file');
        }
      }
    // } else {
    //   print('sdgdffdvdffd');
    //   // Handle permission denial
    // }

  }

  bool checkFileSize(path, context) {
    // file = null;
    var fileSizeLimit = 5;
    File f = new File(path);
    var s = f.lengthSync();
    print(s); // returns in bytes
    var fileSizeInKB = s / 1024;
    var fileSizeInMB = fileSizeInKB / 1024;
    print("size..$fileSizeInMB");
    if (fileSizeInMB > fileSizeLimit) {
      EasyLoading.showToast('File size less than 5MB');
      return false;
    } else {}
    print("file can be selected");
    return true;
  }
}
