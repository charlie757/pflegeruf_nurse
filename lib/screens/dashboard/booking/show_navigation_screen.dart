import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';

class ShowNavigationScreen extends StatefulWidget {
  const ShowNavigationScreen({super.key});

  @override
  State<ShowNavigationScreen> createState() => _ShowNavigationScreenState();
}

class _ShowNavigationScreenState extends State<ShowNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
          )),
          addressWidget()
        ],
      ),
    );
  }

  Widget addressWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getText(
              title: StringKey.deliveryYourOrder.tr,
              size: 17,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
          ScreenSize.height(17),
          Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      color: AppColor.blackColor.withOpacity(.2),
                      blurRadius: 10)
                ]),
            padding:
                const EdgeInsets.only(left: 20, top: 16, bottom: 20, right: 18),
            child: Row(
              children: [
                Image.asset(
                  AppImages.mapLocationIcon,
                  height: 37,
                  width: 20,
                ),
                ScreenSize.width(11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(
                          title: 'Hamburg, Germany',
                          size: 15,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                      ScreenSize.height(4),
                      const getText(
                          title: 'Boxhagener Str. 36, Groß Flottbek, ',
                          size: 13,
                          fontFamily: FontFamily.poppinsRegular,
                          color: AppColor.lightTextColor,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                )
              ],
            ),
          ),
          ScreenSize.height(30),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: AppButton(
                title: StringKey.openMap.tr,
                height: 54,
                width: double.infinity,
                buttonColor: AppColor.appTheme,
                onTap: () {}),
          ),
          ScreenSize.height(30),
        ],
      ),
    );
  }
}
