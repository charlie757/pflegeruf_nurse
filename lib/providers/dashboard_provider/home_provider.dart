import 'package:flutter/material.dart';
import 'package:nurse/api/apiservice.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/model/home_booking_model.dart';
import 'package:nurse/model/home_model.dart';
import 'package:nurse/utils/showcircleprogressdialog.dart';
import 'package:nurse/utils/utils.dart';
import 'package:get/get.dart';

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

  bookingApiFunction() {
    var data = {'': ''};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
            url: ApiUrl.homeBookingListUrl,
            body: body,
            method: checkApiMethod(httpMethod.post),
            isErrorMessageShow: false,
            isBodyNotRequired: true)
        .then((value) {
      if (value != null) {
        bookingModel = HomeBookingModel.fromJson(value);
        // homeModel = HomeModel.fromJson(value);
        notifyListeners();
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
        acceptDialogBox();
        // notifyListeners();
      }
    });
  }

  sendMessageApiFunction(
    String id,
  ) {
    showCircleProgressDialog(navigatorKey.currentContext!);
    var data = {'booking_id': '20', 'message': commentController.text};
    String body = Uri(queryParameters: data).query;
    ApiService.apiMethod(
      url: ApiUrl.sendMessageUrl,
      body: body,
      method: checkApiMethod(httpMethod.post),
      isErrorMessageShow: true,
    ).then((value) {
      Navigator.pop(navigatorKey.currentContext!);
      if (value != null) {
        Navigator.pop(navigatorKey.currentContext!);
        Utils.successSnackBar(value['data'], navigatorKey.currentContext!);
        commentController.clear();
        notifyListeners();
      }
    });
  }

  acceptDialogBox() {
    showGeneralDialog(
      context: navigatorKey.currentContext!,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              // height: 394,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 20, right: 20, bottom: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImages.checkImage,
                          height: 90,
                          width: 90,
                        ),
                      ),
                      ScreenSize.height(32),
                      Align(
                        alignment: Alignment.center,
                        child: getText(
                            title: StringKey.requestAccepted.tr,
                            size: 16,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w600),
                      ),
                      ScreenSize.height(31),
                      getText(
                          title: StringKey.messgeForPatient.tr,
                          size: 12,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.appTheme,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(10),
                      commentTextField(),
                      ScreenSize.height(37),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: AppButton(
                            title: StringKey.send.tr,
                            height: 50,
                            width: double.infinity,
                            buttonColor: AppColor.appTheme,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                sendMessageApiFunction('20');
                              }
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  commentTextField() {
    return TextFormField(
      maxLines: 5,
      controller: commentController,
      decoration: InputDecoration(
        hintText: StringKey.messageForPatientExample.tr,
        hintStyle: TextStyle(
            color: AppColor.lightTextColor.withOpacity(.6),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.poppinsRegular),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.dcColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.dcColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.redColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.redColor)),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Enter your message';
        }
      },
    );
  }
}
