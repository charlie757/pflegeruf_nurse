import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/screens/dashboard/booking/patient_details_screen.dart';
import 'package:nurse/widgets/appBar.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(title: StringKey.bookings.tr),
        body: ListView.separated(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
            separatorBuilder: (context, sp) {
              return ScreenSize.height(10);
            },
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return bookingsWidget();
            }));
  }

  Widget bookingsWidget() {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(const PatientDetailSreen());
      },
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
                  child: Image.asset(
                    'assets/images/dummyRectangle.png',
                    height: 70,
                    width: 70,
                  ),
                ),
                ScreenSize.width(20),
                Flexible(
                  child: getText(
                      title: 'Alexandra Will',
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
                    title: "${StringKey.bookingDate.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                const getText(
                    title: "02 Jan 2023",
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
                    title: "${StringKey.serviceName.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
                const getText(
                    title: "Wound Care",
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
