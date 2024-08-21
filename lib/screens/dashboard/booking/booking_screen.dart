import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/network_imge_helper.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/model/booking_list_model.dart';
import 'package:nurse/providers/dashboard_provider/booking/bookings_provider.dart';
import 'package:nurse/screens/dashboard/booking/patient_details_screen.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<BookingsProvider>(context, listen: false);
    provider.isSelectedTabBar = 0;
    Future.delayed(Duration.zero, () {
      provider.bookingApiFunction(true);
      provider.completedBookingApiFunction(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: getTranslated('bookings', context)!.tr),
        body: Consumer<BookingsProvider>(builder: (context, myProvider, child) {
          return Column(
            children: [
              customTabBar(myProvider),
              Expanded(
                  child: myProvider.isSelectedTabBar == 0
                      ? activeBookingsWidget(myProvider)
                      : completeBookingWidet(myProvider))
            ],
          );
        }));
  }

  activeBookingsWidget(BookingsProvider myProvider) {
    return myProvider.model != null &&
            myProvider.model!.data != null &&
            myProvider.model!.data!.myListing!.isNotEmpty
        ? ListView.separated(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 40),
            separatorBuilder: (context, sp) {
              return ScreenSize.height(10);
            },
            itemCount: myProvider.model!.data!.myListing!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return bookingsWidget(myProvider.model!, index, () {
                AppRoutes.pushCupertinoNavigation(PatientDetailSreen(
                  bookingId: myProvider.model!.data!.myListing![index].bookingId
                      .toString(),
                )).then((value) {
                  myProvider.bookingApiFunction(false);
                });
              });
            })
        : Center(
            child: noDataWidget(),
          );
  }

  completeBookingWidet(BookingsProvider myProvider) {
    return myProvider.completedBookingModel != null &&
            myProvider.completedBookingModel!.data != null &&
            myProvider.completedBookingModel!.data!.myListing!.isNotEmpty
        ? ListView.separated(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 40),
            separatorBuilder: (context, sp) {
              return ScreenSize.height(10);
            },
            itemCount:
                myProvider.completedBookingModel!.data!.myListing!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return bookingsWidget(myProvider.completedBookingModel!, index,
                  () {
                AppRoutes.pushCupertinoNavigation(PatientDetailSreen(
                  bookingId: myProvider
                      .completedBookingModel!.data!.myListing![index].bookingId
                      .toString(),
                )).then((value) {
                  myProvider.completedBookingApiFunction(false);
                });
              });
            })
        : Center(
            child: noDataWidget(),
          );
  }

  Widget bookingsWidget(BookingListModel model, int index, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            const EdgeInsets.only(left: 20, top: 20, bottom: 25, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: model.data!.myListing![index].user != null &&
                          model.data!.myListing![index].user!
                                  .displayProfileImage !=
                              null
                      ? NetworkImageHelper(
                          img: model.data!.myListing![index].user!
                              .displayProfileImage,
                          height: 70.0,
                          width: 70.0,
                        )
                      : const SizedBox(
                          height: 70,
                          width: 70,
                        ),
                ),
                ScreenSize.width(20),
                Flexible(
                  child: getText(
                      title: model.data!.myListing![index].user != null
                          ? "${model.data!.myListing![index].user!.pUserName != null ? model.data!.myListing![index].user!.pUserName.toString().substring(0).toUpperCase()[0] + model.data!.myListing![index].user!.pUserName.toString().substring(1) : ''} ${model.data!.myListing![index].user!.pUserSurname != null ? model.data!.myListing![index].user!.pUserSurname.toString().substring(0).toUpperCase()[0] + model.data!.myListing![index].user!.pUserSurname.toString().substring(1) : ''}"
                          : '',
                      size: 20,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            ScreenSize.height(19),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${getTranslated('bookingDate', context)!.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                getText(
                    title: model.data!.myListing![index].statusCreatedAt != null
                        ? TimeFormat.convertBookingDate(
                            model.data!.myListing![index].statusCreatedAt)
                        : '',
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
            ScreenSize.height(9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${getTranslated('bookingTime', context)!.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                getText(
                    title: model.data!.myListing![index].statusCreatedAt != null
                        ? TimeFormat.convertBookingTime(
                            model.data!.myListing![index].statusCreatedAt)
                        : '',
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
            ScreenSize.height(9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getText(
                    title: "${getTranslated('serviceName', context)!.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                ScreenSize.width(7),
                Flexible(
                  child: getText(
                      title: model.data!.myListing![index].category != null
                          ? model.data!.myListing![index].category!
                                  .categoryName ??
                              ""
                          : "",
                      size: 14,
                      textAlign: TextAlign.right,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  customTabBar(BookingsProvider provier) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provier.isSelectedTabBar != 0) {
                  provier.bookingApiFunction(false);
                  provier.updateSelectedTabBar(0);
                }
              },
              child: Column(
                children: [
                  getText(
                      title: getTranslated('active', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: provier.isSelectedTabBar == 0
                          ? AppColor.textBlackColor
                          : AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  Container(
                    height: 1,
                    color: provier.isSelectedTabBar == 0
                        ? AppColor.textBlackColor
                        : AppColor.borderD9Color,
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (provier.isSelectedTabBar != 1) {
                  provier.completedBookingApiFunction(false);
                  provier.updateSelectedTabBar(1);
                }
              },
              child: Column(
                children: [
                  getText(
                      title: getTranslated('completed', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsMedium,
                      color: provier.isSelectedTabBar == 1
                          ? AppColor.textBlackColor
                          : AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(10),
                  Container(
                    height: 1,
                    color: provier.isSelectedTabBar == 1
                        ? AppColor.textBlackColor
                        : AppColor.borderD9Color,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
