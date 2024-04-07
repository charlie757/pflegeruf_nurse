import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/booking_list_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';

class BookingsProvider extends ChangeNotifier {
  bool isLoading = false;
  BookingListModel? model;

  updateLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  bookingApiFunction() {
    var data = {'': ''};
    showCircleProgressDialog(navigatorKey.currentContext!);
    updateLoading(true);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.bookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      updateLoading(false);
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        model = BookingListModel.fromJson(value);
        notifyListeners();
      } else {
        model = null;
        notifyListeners();
      }
    });
  }
}
