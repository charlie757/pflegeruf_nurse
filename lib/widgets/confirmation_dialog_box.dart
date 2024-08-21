import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/utils/utils.dart';

confirmationDialogBox(
    {required String title,
    required String subTitle,
    required Function() noTap,
    required Function() yesTap}) {
  showGeneralDialog(
    context: navigatorKey.currentContext!,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          // height: 394,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 35, left: 20, right: 20, bottom: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                getText(
                    title: subTitle,
                    size: 14,
                    textAlign: TextAlign.center,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.textBlackColor,
                    fontWeight: FontWeight.w600),
                ScreenSize.height(31),
                Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Row(
                      children: [
                        Flexible(
                          child: AppButton(
                              title: getTranslated(
                                      'no', navigatorKey.currentContext!)!
                                  .tr,
                              height: 50,
                              width: double.infinity,
                              buttonColor: AppColor.redColor,
                              onTap: noTap),
                        ),
                        ScreenSize.width(15),
                        Flexible(
                          child: AppButton(
                              title: getTranslated(
                                      'yes', navigatorKey.currentContext!)!
                                  .tr,
                              height: 50,
                              width: double.infinity,
                              buttonColor: AppColor.appTheme,
                              onTap: yesTap),
                        ),
                      ],
                    ))
              ],
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
