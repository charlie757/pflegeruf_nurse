import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/booking_model.dart';
import 'package:nurse/model/home_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';

class HomeProvider extends ChangeNotifier {
  int currentSliderIndex = 0;
  HomeModel? homeModel;
  BookingModel? bookingModel;
  updateSliderIndex(value) {
    currentSliderIndex = value;
    notifyListeners();
  }

  homeApiFunction() {
    var data = {'': ''};
    homeModel != null
        ? null
        : showCircleProgressDialog(navigatorKey.currentContext!);
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
            url: ApiUrl.homeUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      homeModel != null ? null : Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        homeModel = HomeModel.fromJson(value);
        notifyListeners();
      }
    });
  }

  bookingApiFunction() {
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    print(body);
    ApiService.apiMethod(
            url: ApiUrl.bookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      if (value != null) {
        bookingModel = BookingModel.fromJson(value);
        // homeModel = HomeModel.fromJson(value);
        notifyListeners();
      }
    });
  }
}
