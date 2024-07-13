import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/patient_booking_model.dart';
import 'package:nurse/model/review_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';

class PatientDetailsProvider extends ChangeNotifier {
  bool isLoading = false;
  PatientBookingModel? model;
  ReviewModel? reviewModel;

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  getBookingApiFunction(String id, bool isLoading) async {
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
}
