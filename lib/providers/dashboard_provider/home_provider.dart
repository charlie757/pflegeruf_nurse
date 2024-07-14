import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/home_booking_model.dart';
import 'package:nurse/model/home_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';
import 'package:get/get.dart';
import 'package:nurse/widgets/send_message_booking.dart';

class HomeProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  int currentSliderIndex = 0;
  HomeModel? homeModel;
  HomeBookingModel? bookingModel;
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

  bookingApiFunction(bool isLoading) {
    var data = {'': ''};
    isLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.homeBookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      isLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        bookingModel = HomeBookingModel.fromJson(value);
        // homeModel = HomeModel.fromJson(value);
        notifyListeners();
      } else {
        bookingModel = null;
      }
    });
  }

  acceptBookingApiFunction(String id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var map = {
      'booking_id': id,
    };

    ApiService.multiPartApiMethod(
            url: ApiUrl.acceptBookingUrl, body: map, isErrorMessageShow: true)
        .then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        acceptDialogBox(id, formKey, commentController, () {
          if (formKey.currentState!.validate()) {
            sendMessageApiFunction(
              id,
            );
          }
        });
        // notifyListeners();
      }
    });
  }

  rejectBookingApiFunction(String id) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var map = {
      'booking_id': id,
    };
    ApiService.multiPartApiMethod(
            url: ApiUrl.rejectBookingUrl, body: map, isErrorMessageShow: true)
        .then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        bookingApiFunction(true);
        // notifyListeners();
      }
    });
  }

  sendMessageApiFunction(
    String id,
  ) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {'booking_id': id, 'message': commentController.text};
    print(data);
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.sendMessageUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      isErrorMessageShow: true,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        bookingApiFunction(true);
        Navigator.pop(navigatorKey.currentContext!);
        Utils.successSnackBar(value['data'], navigatorKey.currentContext!);
        commentController.clear();
        notifyListeners();
      }
    });
  }
}
