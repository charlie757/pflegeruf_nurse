import 'package:flutter/material.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:get/get.dart';
import 'package:nurse/utils/utils.dart';

Widget noDataWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        AppImages.noDataIcon,
        height: 136,
        width: 140,
      ),
      ScreenSize.height(24),
      getText(
          title: getTranslated('noData', navigatorKey.currentContext!)!.tr,
          size: 16,
          fontFamily: FontFamily.poppinsRegular,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w400)
    ],
  );
}
