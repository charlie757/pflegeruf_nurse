import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:http/http.dart' as http;
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/model/patient_booking_model.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';
import 'package:get/get.dart';

class PatientDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  PatientBookingModel? model;

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  callApiFunction(String id) async {
    model = null;
    updateLoading(true);
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
}
