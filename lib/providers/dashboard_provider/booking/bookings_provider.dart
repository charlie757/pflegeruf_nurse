import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/booking_list_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';

class BookingsProvider extends ChangeNotifier {
  bool isLoading = false;
  BookingListModel? model;
  BookingListModel? completedBookingModel;

  int isSelectedTabBar = 0;
  updateSelectedTabBar(value) {
    isSelectedTabBar = value;
    notifyListeners();
  }

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  bookingApiFunction(isLoading) {
    var data = {'': ''};
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    updateLoading(isLoading);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.bookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      updateLoading(false);
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        model = BookingListModel.fromJson(value);
        notifyListeners();
      } else {
        model = null;
        notifyListeners();
      }
    });
  }

  completedBookingApiFunction(isLoading) async {
    var data = {'': ''};
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    updateLoading(isLoading);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.completedBookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      updateLoading(false);
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        completedBookingModel = BookingListModel.fromJson(value);
        notifyListeners();
      } else {
        completedBookingModel = null;
        notifyListeners();
      }
    });
  }
}
