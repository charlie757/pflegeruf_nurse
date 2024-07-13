import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';

class NotificationProvider extends ChangeNotifier {
  getNotificationApiFunction() async {
    ///calling in dashboard
    // showLoading ? showCircleProgressDialog(navigatorKey.currentContext!) : null;
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.notificationurl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      // showLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
      if (value != null) {
        // profileModel = ProfileModel.fromJson(value);
        // setControllersValues();
        notifyListeners();
      }
    });
  }
}
