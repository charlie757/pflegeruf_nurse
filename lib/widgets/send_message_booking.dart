import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/utils/utils.dart';

acceptDialogBox(id, GlobalKey formKey, TextEditingController commentController,
    Function() ontap) {
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
                          title: getTranslated('requestAccepted',
                                  navigatorKey.currentContext!)!
                              .tr,
                          size: 16,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.textBlackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ScreenSize.height(31),
                    getText(
                        title: getTranslated('messgeForPatient',
                                navigatorKey.currentContext!)!
                            .tr,
                        size: 12,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.appTheme,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(10),
                    commentTextField(commentController),
                    ScreenSize.height(37),
                    Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: AppButton(
                          title: getTranslated(
                                  'send', navigatorKey.currentContext!)!
                              .tr,
                          height: 50,
                          width: double.infinity,
                          buttonColor: AppColor.appTheme,
                          onTap: ontap
                          //  () {
                          //   if (formKey.currentState!.validate()) {
                          //     sendMessageApiFunction(
                          //       id,
                          //     );
                          //   }
                          // }
                          ),
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

commentTextField(TextEditingController commentController) {
  return TextFormField(
    maxLines: 5,
    controller: commentController,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      hintText: getTranslated(
              'messageForPatientExample', navigatorKey.currentContext!)!
          .tr,
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
