import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/customtextfield.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/network_imge_helper.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/providers/dashboard_provider/profile_provider.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/location_service.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    getLocationPermission();
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<ProfileProvider>(context, listen: false);
    // myProvider.clearValues();
    myProvider.getProfileApiFunction(false);
    myProvider.passwordController.text = SessionManager.userPassword;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          title: getText(
              title: getTranslated('profile', context)!.tr,
              size: 20,
              fontFamily: FontFamily.poppinsSemiBold,
              color: AppColor.textBlackColor,
              fontWeight: FontWeight.w600),
          actions: [
            GestureDetector(
              onTap: () { 
                openBottomSheetOptions();
                // Navigator.pop(context);
              },
              child: Container(
                width: 60,
                alignment: Alignment.center,
                child: Icon(
                  Icons.more_vert_outlined,
                  color: AppColor.textBlackColor.withOpacity(.5),
                  size: 22,
                ),
              ),
            ),
          ],
        ),
        body: Consumer<ProfileProvider>(builder: (context, myProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.58, right: 20, bottom: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileImageWidget(myProvider),
                  ScreenSize.height(27),
                  getText(
                      title: getTranslated('firstName', context)!.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.firstNameController,
                    hintText: getTranslated('enterFirstName', context)!.tr,
                    errorMsg: myProvider.firstNamevalidationMsg,
                    onChanged: (val) {
                      myProvider.firstNamevalidationMsg =
                          AppValidation.firstNameValidator(val);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.edit,
                        color: AppColor.textBlackColor.withOpacity(.3),
                        size: 20,
                      ),
                    ),
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: getTranslated('lastName', context)!.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.lastNameController,
                    hintText: getTranslated('enterLastName', context)!.tr,
                    errorMsg: myProvider.lastNamevalidationMsg,
                    onChanged: (val) {
                      myProvider.lastNamevalidationMsg =
                          AppValidation.lastNameValidator(val);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.edit,
                        color: AppColor.textBlackColor.withOpacity(.3),
                        size: 20,
                      ),
                    ),
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: getTranslated('email', context)!.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.emailController,
                    hintText: getTranslated('enterYourEmail', context)!.tr,
                    isReadOnly: true,
                    errorMsg: myProvider.emailValidationMsg,
                    onChanged: (val) {
                      myProvider.emailValidationMsg =
                          AppValidation.emailValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: getTranslated('phoneNumber', context)!.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.phoneController,
                    hintText:
                        getTranslated('enterYourPhonenUmber', context)!.tr,
                    textInputType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12)
                    ],
                    errorMsg: myProvider.phoneValidationMsg,
                    onChanged: (val) {
                      myProvider.phoneValidationMsg =
                          AppValidation.phoneNumberValidator(val);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.edit,
                        color: AppColor.textBlackColor.withOpacity(.3),
                        size: 20,
                      ),
                    ),
                  ),
                  ScreenSize.height(20),
                  getText(
                      title: getTranslated('password', context)!.tr,
                      size: 13,
                      fontFamily: FontFamily.poppinsRegular,
                      color: AppColor.textBlackColor.withOpacity(.6),
                      fontWeight: FontWeight.w400),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.passwordController,
                    hintText: getTranslated('enterYourPasword', context)!.tr,
                    isObscureText: myProvider.isVisiblePassword,
                    isReadOnly: true,
                    errorMsg: myProvider.passwordValidationMsg,
                    onChanged: (val) {
                      myProvider.passwordValidationMsg =
                          AppValidation.reEnterpasswordValidator(
                              val, myProvider.passwordController.text);
                      setState(() {});
                    },
                    icon: GestureDetector(
                      onTap: () {
                        if (myProvider.isVisiblePassword) {
                          myProvider.updateIsVisiblePassword(false);
                        } else {
                          myProvider.updateIsVisiblePassword(true);
                        }
                      },
                      child: Icon(
                        myProvider.isVisiblePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColor.textBlackColor.withOpacity(.3),
                        size: 20,
                      ),
                    ),
                  ),
                  ScreenSize.height(50),
                  Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: AppButton(
                        title: getTranslated('saveChanges', context)!.tr,
                        height: 54,
                        width: double.infinity,
                        buttonColor: AppColor.appTheme,
                        onTap: () {
                          myProvider.checkValidation();
                        }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  profileImageWidget(ProfileProvider provider) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          provider.profileModel != null &&
                  provider.profileModel!.data != null &&
                  provider.profileModel!.data!.details!.displayProfileImage
                      .isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: NetworkImageHelper(
                    img: provider
                        .profileModel!.data!.details!.displayProfileImage,
                    height: 100.0,
                    width: 100.0,
                  ),
                )
              : provider.imgFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(provider.imgFile!.path),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ))
                  : Image.asset(
                      'assets/images/dummyProfile.png',
                      height: 100,
                      width: 100,
                    ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                imagePickerBottomSheet(provider);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  Icons.edit,
                  color: AppColor.textBlackColor.withOpacity(.3),
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  openBottomSheetOptions() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: OutlineInputBorder(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            borderSide: BorderSide(color: AppColor.whiteColor)),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    openDialogBox(
                        isLogout: true,
                        title: getTranslated('youWantToLogout', context)!.tr,
                        noTap: () {
                          Navigator.pop(context);
                        },
                        yesTap: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .logoutApiFunction();
                          // Utils.logOut();
                        });
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getText(
                            title: getTranslated('logout', context)!.tr,
                            size: 16,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w400),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: AppColor.appTheme,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                ScreenSize.height(13),
                // Container(
                //   height: 1,
                //   color: const Color(0xffDDE0E4),
                // ),
                // ScreenSize.height(13),
                // GestureDetector(
                //   onTap: () {
                //     openDialogBox(
                //         isLogout: false,
                //         title: StringKey.youWantToDeleteAccount.tr,
                //         noTap: () {
                //           Navigator.pop(context);
                //         },
                //         yesTap: () {
                //           Provider.of<ProfileProvider>(context,listen: false).deleteAccountApiFunction();
                //         });
                //   },
                //   child: Container(
                //     color: Colors.transparent,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         getText(
                //             title: StringKey.deleteAccount.tr,
                //             size: 16,
                //             fontFamily: FontFamily.poppinsMedium,
                //             color: AppColor.textBlackColor,
                //             fontWeight: FontWeight.w400),
                //         Icon(
                //           Icons.arrow_forward_ios_outlined,
                //           color: AppColor.appTheme,
                //           size: 20,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        });
  }

  void openDialogBox(
      {required bool isLogout,
      required String title,
      required Function() noTap,
      required Function() yesTap}) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            Center(
              child: Container(
                // height: 394,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 35, left: 20, right: 20, bottom: 33),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      ScreenSize.height(47),
                      Row(
                        children: [
                          Flexible(
                            child: AppButton(
                                title: getTranslated('no', context)!.tr,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.whiteColor,
                                textColor: AppColor.textBlackColor,
                                onTap: noTap),
                          ),
                          ScreenSize.width(20),
                          Flexible(
                            child: AppButton(
                                title: getTranslated('yes', context)!.tr,
                                height: 50,
                                width: double.infinity,
                                buttonColor: AppColor.appTheme,
                                onTap: yesTap),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Positioned(
            //     right: 0 + 33,
            //     top: isLogout
            //         ? MediaQuery.of(context).size.height / 2.8
            //         : MediaQuery.of(context).size.height / 2.9,
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Image.asset(
            //         AppImages.closeIcon,
            //         height: 25,
            //         width: 25,
            //       ),
            //     ))
          ],
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

  imagePickerBottomSheet(ProfileProvider profileProvider) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getText(
                        title: 'Profile Photo',
                        size: 17,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close))
                  ],
                ),
                ScreenSize.height(25),
                Row(
                  children: [
                    imagePickType(Icons.camera_alt_outlined, 'Camera', () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.camera);
                    }),
                    ScreenSize.width(30),
                    imagePickType(Icons.image_outlined, 'Gallery', () {
                      Navigator.pop(context);
                      profileProvider.imagePicker(ImageSource.gallery);
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }

  imagePickType(icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColor.lightTextColor.withOpacity(.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColor.blackColor.withOpacity(.3),
            ),
          ),
          ScreenSize.height(5),
          getText(
              title: title,
              size: 14,
              fontFamily: FontFamily.poppinsRegular,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}
