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
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/providers/dashboard_provider/home_provider.dart';
import 'package:nurse/providers/dashboard_provider/profile_provider.dart';
import 'package:nurse/screens/dashboard/booking/patient_details_screen.dart';
import 'package:nurse/screens/dashboard/notification_screen.dart';
import 'package:nurse/utils/timeformat.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/no_data_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<HomeProvider>(context, listen: false);
    myProvider.homeApiFunction();
    myProvider.bookingApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

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
                    profileProvider.profileModel != null &&
                            profileProvider.profileModel!.data != null &&
                            profileProvider.profileModel!.data!.details !=
                                null &&
                            profileProvider.profileModel!.data!.details!
                                .displayProfileImage.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: NetworkImageHelper(
                              img: profileProvider.profileModel!.data!.details!
                                  .displayProfileImage,
                              height: 40.0,
                              width: 40.0,
                              isAnotherColorOfLodingIndicator: true,
                            ))
                        : Image.asset(
                            'assets/images/dummyProfile.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                    ScreenSize.width(10),
                    Flexible(
                      child: getText(
                          title:
                              '${StringKey.welcome.tr}, ${profileProvider.profileModel != null && profileProvider.profileModel!.data != null && profileProvider.profileModel!.data!.details != null ? (profileProvider.profileModel!.data!.details!.firstName.toString().substring(0).toUpperCase()[0] + profileProvider.profileModel!.data!.details!.firstName.toString().substring(1)) : ''}',
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
                          const NotificationScreen());
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
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              height: 16,
                              width: 16,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.appTheme,
                                  borderRadius: BorderRadius.circular(8)),
                              child: getText(
                                  title: '2',
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              title: StringKey.bookingsForYou.tr,
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
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(PatientDetailSreen(
          bookingId: provider.bookingModel!.data!.myListing![index].bookingId
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
                    title: provider
                                .bookingModel!.data!.myListing![index].user !=
                            null
                        ? "${provider.bookingModel!.data!.myListing![index].user!.pUserName != null ? provider.bookingModel!.data!.myListing![index].user!.pUserName.toString().substring(0).toUpperCase()[0] + provider.bookingModel!.data!.myListing![index].user!.pUserName.toString().substring(1) : ''} ${provider.bookingModel!.data!.myListing![index].user!.pUserSurname != null ? provider.bookingModel!.data!.myListing![index].user!.pUserSurname.toString().substring(0).toUpperCase()[0] + provider.bookingModel!.data!.myListing![index].user!.pUserSurname.toString().substring(1) : ''}"
                        : '',
                    size: 20,
                    fontFamily: FontFamily.poppinsMedium,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600),
                getText(
                    title: TimeFormat.convertBookingTime(provider.bookingModel!
                        .data!.myListing![index].productCreatedAt),
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
                          "${provider.bookingModel!.data!.myListing![index].address ?? ''}, ${provider.bookingModel!.data!.myListing![index].street ?? ''}, ${provider.bookingModel!.data!.myListing![index].city ?? ''}, ${provider.bookingModel!.data!.myListing![index].postalCode ?? ''}",
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
                      title: "${StringKey.bookingDate.tr}:",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  getText(
                      title: provider.bookingModel!.data!.myListing![index]
                                  .productCreatedAt !=
                              null
                          ? TimeFormat.convertBookingDate(provider.bookingModel!
                              .data!.myListing![index].productCreatedAt)
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
                      title: "${StringKey.serviceName.tr}:",
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w600),
                  ScreenSize.width(5),
                  Flexible(
                    child: Text(
                      provider.bookingModel!.data!.myListing![index].category !=
                              null
                          ? provider.bookingModel!.data!.myListing![index]
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
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Flexible(
                    child: AppButton(
                        title: StringKey.accept.tr,
                        height: 45,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          confirmationDialogBox(
                              title: StringKey.accept.tr,
                              subTitle:
                                  StringKey.confirmationToAcceptRequest.tr,
                              noTap: () {
                                Navigator.pop(context);
                              },
                              yesTap: () {
                                Navigator.pop(context);
                                provider.acceptBookingApiFunction(
                                  provider.bookingModel!.data!.myListing![index]
                                      .bookingId
                                      .toString(),
                                );
                              });
                          // acceptDialogBox();
                        }),
                  ),
                  ScreenSize.width(20),
                  Flexible(
                    child: AppButton(
                        title: StringKey.reject.tr,
                        height: 45,
                        width: double.infinity,
                        buttonColor: AppColor.rejectColor,
                        onTap: () {
                          confirmationDialogBox(
                              title: StringKey.reject.tr,
                              subTitle:
                                  StringKey.confirmationToRejectRequest.tr,
                              noTap: () {
                                Navigator.pop(context);
                              },
                              yesTap: () {
                                Navigator.pop(context);
                                provider.rejectBookingApiFunction(
                                  provider.bookingModel!.data!.myListing![index]
                                      .bookingId
                                      .toString(),
                                );
                              });
                        }),
                  ),
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
                        viewportFraction: .9,
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

  confirmationDialogBox(
      {required String title,
      required String subTitle,
      required Function() noTap,
      required Function() yesTap}) {
    showGeneralDialog(
      context: context,
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
              padding: const EdgeInsets.only(
                  top: 35, left: 20, right: 20, bottom: 33),
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
                                title: StringKey.no.tr,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.redColor,
                                onTap: noTap),
                          ),
                          ScreenSize.width(15),
                          Flexible(
                            child: AppButton(
                                title: StringKey.yes.tr,
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
}
