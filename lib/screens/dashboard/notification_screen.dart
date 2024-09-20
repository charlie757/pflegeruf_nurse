import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/providers/dashboard_provider/notification_provider.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/confirmation_dialog_box.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.getNotificationApiFunction(true);
      provider.readNotificationApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: getTranslated('notification', context)!.tr, showLeading: true),
      body:
          Consumer<NotificationProvider>(builder: (context, myProvider, child) {
        return myProvider.model != null
            ? myProvider.model!.data!.isEmpty || myProvider.model!.data == null
                ? Align(alignment: Alignment.center, child: noDataWidget())
                : ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.height(25);
                    },
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    itemCount: myProvider.model!.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return notificationWidget(index, myProvider);
                    })
            : Container();
      }),
    );
  }

  notificationWidget(int index, NotificationProvider provider) {
    var model = provider.model!.data![index];
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
                        title: model.msg ?? "",
                        size: 15,
                        fontFamily: FontFamily.poppinsSemiBold,
                        color: AppColor.textBlackColor,
                        fontWeight: FontWeight.w600),
                    ScreenSize.height(10),
                    getText(
                        title: model.notificationCreatedAt != null
                            ? TimeFormat.convertNotificationDate(
                                model.notificationCreatedAt)
                            : "",
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: const Color(0xff606573),
                        fontWeight: FontWeight.w400)
                  ],
                ),
              )
            ],
          ),
        ),
        ScreenSize.height(model.currentStatus == 'NEW' ? 25 : 0),
        model.currentStatus == 'NEW'
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Flexible(
                        child: customBtn(AppColor.appTheme,
                            getTranslated('accept', context)!.tr, () {
                      confirmationDialogBox(
                          title: getTranslated('accept', context)!.tr,
                          subTitle: getTranslated(
                                  'confirmationToAcceptRequest', context)!
                              .tr,
                          noTap: () {
                            Navigator.pop(context);
                          },
                          yesTap: () {
                            Navigator.pop(context);
                            provider.acceptBookingApiFunction(
                              model.bookingId.toString(),
                            );
                          });
                    })),
                    ScreenSize.width(10),
                    Flexible(
                        child: customBtn(AppColor.rejectColor,
                            getTranslated('reject', context)!.tr, () {
                      confirmationDialogBox(
                          title: getTranslated('reject', context)!.tr,
                          subTitle: getTranslated(
                                  'confirmationToRejectRequest', context)!
                              .tr,
                          noTap: () {
                            Navigator.pop(context);
                          },
                          yesTap: () {
                            Navigator.pop(context);
                            provider.rejectBookingApiFunction(
                              model.bookingId.toString(),
                            );
                          });
                    })),
                  ],
                ),
              )
            : Container(),
        ScreenSize.height(30),
        Container(
          height: 1,
          color: AppColor.borderColor,
        )
      ],
    );
  }

  customBtn(Color color, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        width: double.infinity,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: getText(
            title: title,
            size: 14,
            textAlign: TextAlign.center,
            fontFamily: FontFamily.poppinsSemiBold,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
