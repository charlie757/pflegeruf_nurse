import 'dart:async';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/network_imge_helper.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/providers/dashboard_provider/dashboard_provider.dart';
import 'package:nurse/providers/dashboard_provider/home_provider.dart';
import 'package:nurse/providers/dashboard_provider/notification_provider.dart';
import 'package:nurse/providers/dashboard_provider/profile_provider.dart';
import 'package:nurse/screens/dashboard/booking/patient_details_screen.dart';
import 'package:nurse/screens/dashboard/notification_screen.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/confirmation_dialog_box.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../utils/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Timer? timer;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      callInitFunction(false);
    });

    super.initState();
  }

  
  @override
  void dispose() {
   timer!=null? timer!.cancel():null;
    super.dispose();
  }

int apiCallingCount = 0;

  callInitFunction(bool isLoading) async{
    final myProvider = Provider.of<HomeProvider>(context, listen: false);
    myProvider.homeApiFunction();
      myProvider.bookingApiFunction(isLoading);
    Provider.of<NotificationProvider>(context, listen: false)
        .unreadNotificationApiFunction();
      timer= Timer.periodic(const Duration(seconds:8),(val){
       getLocationPermission();
       Future.delayed(const Duration(seconds: 3),(){
        myProvider.bookingApiFunction(false);
        apiCallingCount+=1;
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<HomeProvider>(builder: (context, myProvider, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.appTheme,
              automaticallyImplyLeading: false,
              scrolledUnderElevation: 0.0,
              title: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        dashboardProvider.updateSelectedIndex(2);
                      },
                      child: profileProvider.profileModel != null &&
                              profileProvider.profileModel!.data != null &&
                              profileProvider.profileModel!.data!.details !=
                                  null &&
                              profileProvider.profileModel!.data!.details!
                                  .displayProfileImage.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: NetworkImageHelper(
                                img: profileProvider.profileModel!.data!
                                    .details!.displayProfileImage,
                                height: 40.0,
                                width: 40.0,
                                isAnotherColorOfLodingIndicator: true,
                              ))
                          : Image.asset(
                              AppImages.bottomIcon3,
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                    ),
                    ScreenSize.width(10),
                    Flexible(
                      child: getText(
                          title:
                              '${getTranslated('welcome', context)!.tr}, ${profileProvider.profileModel != null && profileProvider.profileModel!.data != null && profileProvider.profileModel!.data!.details != null ? (profileProvider.profileModel!.data!.details!.firstName.toString().substring(0).toUpperCase()[0] + profileProvider.profileModel!.data!.details!.firstName.toString().substring(1)) : ''}',
                          size: 16,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(
                              const NotificationScreen())
                          .then((value) {
                        myProvider.bookingApiFunction(false);
                      });
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.asset(
                              AppImages.bellIcon,
                              height: 26,
                              width: 26,
                            ),
                          ),
                          Provider.of<NotificationProvider>(context)
                                      .unreadNotificationCount ==
                                  0
                              ? Container()
                              : Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, -2),
                                              color: AppColor.blackColor
                                                  .withOpacity(.2),
                                              blurRadius: 10)
                                        ],
                                        color: AppColor.appTheme,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: getText(
                                        title: Provider.of<NotificationProvider>(
                                                        context)
                                                    .unreadNotificationCount >
                                                99
                                            ? "+99"
                                            : Provider.of<NotificationProvider>(
                                                    context)
                                                .unreadNotificationCount
                                                .toString(),
                                        size: 9,
                                        fontFamily: FontFamily.poppinsBold,
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: ()async{
                Future.delayed(const Duration(milliseconds: 1),(){
                  callInitFunction(true);
                });
              },
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerWidget(myProvider),
                  ScreenSize.height(40),
                  bookingForYouWidget(myProvider)
                ],
              ),
            ));
      }),
    );
  }

  bookingForYouWidget(HomeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: getText(
              title: getTranslated('bookingsForYou', context)!.tr,
              size: 22,
              fontFamily: FontFamily.poppinsMedium,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
        ),
        ScreenSize.height(37),
        provider.bookingModel != null &&
                provider.bookingModel!.data != null &&
                provider.bookingModel!.data!.myListing != null
            ? provider.bookingModel!.data!.myListing!.isEmpty
                ? Center(
                    child: noDataWidget(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.height(20);
                    },
                    itemCount: provider.bookingModel!.data!.myListing!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 50),
                    itemBuilder: (context, index) {
                      return bookingUi(provider, index);
                    })
            : Container(),
      ],
    );
  }

  bookingUi(HomeProvider provider, int index) {
    var model = provider.bookingModel!.data!.myListing![index];
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(PatientDetailSreen(
          bookingId: model.bookingId
              .toString(),
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
            const EdgeInsets.only(left: 18, top: 25, bottom: 25, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getText(
                    title: model.user !=
                            null
                        ? "${model.user!.pUserName != null ? model.user!.pUserName.toString().substring(0).toUpperCase()[0] + model.user!.pUserName.toString().substring(1) : ''} ${model.user!.pUserSurname != null ? model.user!.pUserSurname.toString().substring(0).toUpperCase()[0] + model.user!.pUserSurname.toString().substring(1) : ''}"
                        : '',
                    size: 20,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                getText(
                    title: TimeFormat.convertBookingTime(model.statusCreatedAt),
                    size: 14,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.rejectColor,
                    fontWeight: FontWeight.w400)
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
                Flexible(
                  child: getText(
                      title:
                          "${model.houseNUmber??''}, ${model.address.isEmpty || model.address != null ? '' : "${model.address},"} ${model.street ?? ''}, ${model.city ?? ''}, ${model.postalCode ?? ''}",
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.lightTextColor,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            ScreenSize.height(24),
            Padding(
              padding: const EdgeInsets.only(left: 45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      title: "${getTranslated('bookingDate', context)!.tr}:",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  getText(
                      title: model
                                  .productCreatedAt !=
                              null
                          ? TimeFormat.convertBookingDate(model.productCreatedAt)
                          : '',
                      size: 15,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      title: "${getTranslated('bookingTime', context)!.tr}:",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  getText(
                      title:model
                                  .productCreatedAt !=
                              null
                          ? TimeFormat.convertBookingTime(model.statusCreatedAt)
                          : '',
                      size: 15,
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getText(
                      title: "${getTranslated('serviceName', context)!.tr}:",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  ScreenSize.width(5),
                  Flexible(
                    child: Text(
                      model.category !=
                              null
                          ? model
                                  .category!.categoryName ??
                              ""
                          : "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontFamily.poppinsMedium,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            ScreenSize.height(30),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                children: [
                  Flexible(
                    child:  GestureDetector(
                      onTap: (){
                        confirmationDialogBox(
                            title: getTranslated('accept', context)!.tr,
                            subTitle: getTranslated(
                                'confirmationToAcceptRequest', context)!
                                .tr,
                            noTap: () {
                              Navigator.pop(context);
                            },
                            yesTap: () {
                              print(
                                model
                                    .bookingId
                                    .toString(),
                              );
                              Navigator.pop(context);
                              provider.acceptBookingApiFunction(
                                model
                                    .bookingId
                                    .toString(),
                              );
                            });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 55,
                        padding:const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColor.appTheme,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: getText(title: getTranslated('accept', context)!.tr,size: 16,
                            fontFamily: FontFamily.poppinsSemiBold,
                            textAlign: TextAlign.center,
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    // AppButton(
                    //     title: getTranslated('accept', context)!.tr,
                    //     height: 45,
                    //     width: double.infinity,
                    //     buttonColor: AppColor.appTheme,
                    //     onTap: () {
                    //       confirmationDialogBox(
                    //           title: getTranslated('accept', context)!.tr,
                    //           subTitle: getTranslated(
                    //                   'confirmationToAcceptRequest', context)!
                    //               .tr,
                    //           noTap: () {
                    //             Navigator.pop(context);
                    //           },
                    //           yesTap: () {
                    //             print(
                    //               provider.bookingModel!.data!.myListing![index]
                    //                   .bookingId
                    //                   .toString(),
                    //             );
                    //             Navigator.pop(context);
                    //             provider.acceptBookingApiFunction(
                    //               provider.bookingModel!.data!.myListing![index]
                    //                   .bookingId
                    //                   .toString(),
                    //             );
                    //           });
                    //     }),
                    //
                  ),
                  ScreenSize.width(15),
                  AppButton(
                      title: getTranslated('reject', context)!.tr,
                      height: 55,
                      width: 80,
                      buttonColor: AppColor.rejectColor,
                      onTap: () {
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
                                model
                                    .bookingId
                                    .toString(),
                              );
                            });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  headerWidget(HomeProvider provider) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.appTheme,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      padding: const EdgeInsets.only(top: 18, bottom: 35),
      child: Column(
        children: [
          provider.homeModel != null &&
                  provider.homeModel!.data != null &&
                  provider.homeModel!.data!.banners!.isNotEmpty
              ? SizedBox(
                  height: 168,
                  // color: Colors.red,
                  child: CarouselSlider.builder(
                    itemCount: provider.homeModel!.data!.banners!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: NetworkImageHelper(
                              img:
                                  "${provider.homeModel!.data!.bannerPath}${provider.homeModel!.data!.banners![itemIndex].bannerImage}",
                              height: 168.0,
                              width: double.infinity,
                              isAnotherColorOfLodingIndicator: true,
                            )),
                      );
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        scrollDirection: Axis.horizontal,
                        // enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        initialPage: 0,
                        autoPlayCurve: Curves.ease,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 400),
                        autoPlayInterval: const Duration(seconds: 2),
                        onPageChanged: (val, _) {
                          provider.updateSliderIndex(val);
                        }),
                  ),
                )
              : const SizedBox.shrink(),
          ScreenSize.height(20),
          provider.homeModel != null &&
                  provider.homeModel!.data != null &&
                  provider.homeModel!.data!.banners!.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      provider.homeModel!.data!.banners!.length, (index) {
                    return provider.currentSliderIndex == index
                        ? indicator(true)
                        : indicator(false);
                  }))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        height: isActive ? 5 : 7.0,
        width: isActive ? 25 : 7.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive
              ? AppColor.whiteColor
              : AppColor.whiteColor.withOpacity(.5),
        ),
      ),
    );
  }
}
