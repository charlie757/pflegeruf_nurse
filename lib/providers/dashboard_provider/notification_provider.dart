import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/model/notification_model.dart';
import 'package:nurse/screens/dashboard/dashboard_screen.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/send_message_booking.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? model;
  final formKey = GlobalKey<FormState>();
  final commentController = TextEditingController();
  List newNotificationList = [];

  getNotificationApiFunction(bool showLoading) async {
    model = null;
    showLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.notificationurl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      showLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        model = NotificationModel.fromJson(value);
        notifyListeners();
      } else {
        newNotificationList.clear();
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
        getNotificationApiFunction(false);
        Navigator.pop(navigatorKey.currentContext!);
        Navigator.pushAndRemoveUntil(
            navigatorKey.currentContext!,
            MaterialPageRoute(
                builder: (context) => const DashboardScreen(
                      index: 1,
                    )),
            (Route<dynamic> route) => false);
        Utils.successSnackBar(value['data'], navigatorKey.currentContext!);
        commentController.clear();
        notifyListeners();
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
        getNotificationApiFunction(true);
        Utils.successSnackBar(value['message'], navigatorKey.currentContext!);
        // bookingApiFunction(true);
        // notifyListeners();
      }
    });
  }
}
