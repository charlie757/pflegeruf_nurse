import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/providers/dashboard_provider/booking/patient_details_provider.dart';
import 'package:nurse/screens/dashboard/booking/reviews_screen.dart';
import 'package:nurse/screens/dashboard/booking/show_navigation_screen.dart';
import 'package:nurse/utils/enum_booking_status.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:nurse/widgets/ratingwidget.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class PatientDetailSreen extends StatefulWidget {
  final bookingId;
  const PatientDetailSreen({super.key, this.bookingId});

  @override
  State<PatientDetailSreen> createState() => _PatientDetailSreenState();
}

class _PatientDetailSreenState extends State<PatientDetailSreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider =
        Provider.of<PatientDetailsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.callApiFunction(widget.bookingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientDetailsProvider>(
        builder: (context, myProider, child) {
      return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: appBar(title: StringKey.patientDetails.tr, showLeading: true),
          body: myProider.isLoading
              ? Center(child: noDataWidget())
              : myProider.model != null &&
                      myProider.model!.data != null &&
                      myProider.model!.data!.myListing != null
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenSize.height(5),
                          patientDetailsWidget(myProider),
                          ScreenSize.height(35),
                          reviewsWidget(),
                          ScreenSize.height(50),
                          myProider.model!.data!.myListing!.bookingStatus ==
                                  BookingTypes.ACCEPTED.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 37, right: 37),
                                  child: AppButton(
                                      title: StringKey.endBooking.tr,
                                      height: 54,
                                      width: double.infinity,
                                      buttonColor: AppColor.appTheme,
                                      onTap: () {}),
                                )
                              : Container(),
                          ScreenSize.height(40),
                        ],
                      ),
                    )
                  : Container());
    });
  }

  Widget patientDetailsWidget(PatientDetailsProvider provider) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 6),
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 20, top: 28, bottom: 25, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                provider.model!.data!.myListing!.patient != null &&
                        provider.model!.data!.myListing!.patient!.name != null
                    ? provider.model!.data!.myListing!.patient!.name
                            .toString()
                            .substring(0)
                            .toUpperCase()[0] +
                        provider.model!.data!.myListing!.patient!.name
                            .toString()
                            .substring(1)
                    : '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
              )),
              getText(
                  title: provider.model!.data!.myListing!.bookingStatus ==
                          BookingTypes.NEW.value
                      ? "(${StringKey.pending.tr})"
                      : provider.model!.data!.myListing!.bookingStatus ==
                              BookingTypes.ACCEPTED.value
                          ? "(${StringKey.accept.tr})"
                          : "(${StringKey.completed.tr})",
                  size: 12,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: provider.model!.data!.myListing!.bookingStatus ==
                          BookingTypes.NEW.value
                      ? AppColor.redColor
                      : provider.model!.data!.myListing!.bookingStatus ==
                              BookingTypes.ACCEPTED.value
                          ? AppColor.greenColor
                          : AppColor.appTheme,
                  fontWeight: FontWeight.w600)
            ],
          ),
          ScreenSize.height(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.locationIcon,
                height: 22,
                width: 22,
              ),
              ScreenSize.width(17),
              const Flexible(
                child: getText(
                    title: '',
                    // 'Boxhagener Str. 36, Hamburg Groß Flottbek, Hamburg, Germany',
                    size: 13,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.lightTextColor,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          ScreenSize.height(24),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${StringKey.bookingDate.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                getText(
                    title: provider.model!.data!.myListing!.bookingDate != null
                        ? TimeFormat.convertBookingDate(
                            provider.model!.data!.myListing!.bookingDate)
                        : "",
                    size: 15,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: "${StringKey.serviceName.tr}:",
                    size: 14,
                    fontFamily: FontFamily.poppinsSemiBold,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                Flexible(
                  child: Text(
                    provider.model!.data!.myListing!.service != null &&
                            provider.model!.data!.myListing!.service!.name !=
                                null
                        ? provider.model!.data!.myListing!.service!.name
                        : "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          ScreenSize.height(29),
          getText(
              title: StringKey.details.tr,
              size: 15,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
          ScreenSize.height(10),
          detailsWidget(provider),
          ScreenSize.height(43),
          provider.model!.data!.myListing!.bookingStatus ==
                  BookingTypes.NEW.value
              ? Container()
              : AppButton(
                  title: StringKey.showNavigation.tr,
                  height: 54,
                  width: double.infinity,
                  buttonColor: AppColor.rejectColor,
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(
                        const ShowNavigationScreen());
                  })
        ],
      ),
    );
  }

  Widget reviewsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getText(
                  title: StringKey.reviews.tr,
                  size: 16,
                  fontFamily: FontFamily.poppinsMedium,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w600),
              GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(const ReviewsScreen());
                },
                child: getText(
                    title: StringKey.seeAll.tr,
                    size: 13,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blueColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        ScreenSize.height(15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [for (int i = 0; i < 4; i++) reviewsUI()],
            ),
          ),
        )
      ],
    );
  }

  Widget reviewsUI() {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(left: 7, right: 7),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 25, right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/dummyProfile.png',
                height: 46,
                width: 46,
              ),
              ScreenSize.width(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alexandra Will',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600),
                    ),
                    ScreenSize.height(1),
                    const getText(
                        title: 'Yoga Class',
                        size: 14,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.lightTextColor,
                        fontWeight: FontWeight.w400)
                  ],
                ),
              ),
              const getText(
                  title: 'Oct 23, 22',
                  size: 12,
                  fontFamily: FontFamily.poppinsRegular,
                  color: AppColor.lightTextColor,
                  fontWeight: FontWeight.w400)
            ],
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.only(left: 52),
            child: ratingWidget(18),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 52, top: 12),
            child: ReadMoreText(
              'It is a long established fact that a reader will be distracted by the readable content of a page when looking',
              trimLines: 3,
              colorClickableText: Colors.pink,
              lessStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blueColor,
                  fontFamily: FontFamily.poppinsRegular),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.lightTextColor,
                  fontFamily: FontFamily.poppinsRegular),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'read more',
              trimExpandedText: ' read less',
              moreStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blueColor,
                  fontFamily: FontFamily.poppinsRegular),
            ),
          )
        ],
      ),
    );
  }

  Widget detailsWidget(PatientDetailsProvider provider) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF9F6FF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 25, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customDetailsRow(
              StringKey.insurance.tr,
              provider.model!.data!.myListing!.patient != null &&
                      provider.model!.data!.myListing!.patient!.insurance !=
                          null
                  ? provider.model!.data!.myListing!.patient!.insurance
                  : ''),
          ScreenSize.height(10),
          customDetailsRow(
              StringKey.insuranceNo.tr,
              provider.model!.data!.myListing!.patient != null &&
                      provider.model!.data!.myListing!.patient!
                              .insuranceNumber !=
                          null
                  ? provider.model!.data!.myListing!.patient!.insuranceNumber
                  : ''),
          ScreenSize.height(10),
          customDetailsRow(
              StringKey.birthDate.tr,
              provider.model!.data!.myListing!.patient != null &&
                      provider.model!.data!.myListing!.patient!.dob != null
                  ? TimeFormat.convertBookingDate(
                      provider.model!.data!.myListing!.patient!.dob)
                  : ""),
        ],
      ),
    );
  }

  customDetailsRow(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: getText(
              title: "$title:",
              size: 14,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400),
        ),
        ScreenSize.width(20),
        Flexible(
          child: Container(
            alignment: Alignment.centerLeft,
            child: getText(
                title: subTitle,
                size: 15,
                fontFamily: FontFamily.poppinsMedium,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
