import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/widgets/appBar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: StringKey.notification.tr, showLeading: true),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(25);
          },
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return notificationWidget();
          }),
    );
  }

  notificationWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 21),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 43,
                width: 43,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 10,
                          color: AppColor.textBlackColor.withOpacity(.2))
                    ]),
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.bellIcon,
                  color: AppColor.appTheme,
                  height: 20,
                  width: 20,
                ),
              ),
              ScreenSize.width(19),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getText(
                        title:
                            'Your booking from Alexandra for wound care service',
                        size: 15,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(10),
                    const getText(
                        title: '23 July 22 at 09:15 AM',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: Color(0xff606573),
                        fontWeight: FontWeight.w400)
                  ],
                ),
              )
            ],
          ),
        ),
        ScreenSize.height(25),
        Padding(
          padding: const EdgeInsets.only(left: 100, right: 20),
          child: Row(
            children: [
              Flexible(
                  child: customBtn(AppColor.appTheme, StringKey.accept.tr)),
              ScreenSize.width(20),
              Flexible(
                  child: customBtn(AppColor.rejectColor, StringKey.reject.tr)),
            ],
          ),
        ),
        ScreenSize.height(30),
        Container(
          height: 1,
          color: AppColor.borderColor,
        )
      ],
    );
  }

  customBtn(Color color, String title) {
    return Container(
      height: 37,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      width: double.infinity,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: getText(
          title: title,
          size: 14,
          fontFamily: FontFamily.poppinsSemiBold,
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w600),
    );
  }
}
