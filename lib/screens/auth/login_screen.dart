import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nurse/api/apiurl.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/customtextfield.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/providers/auth_provider/login_provider.dart';
import 'package:nurse/screens/auth/forgot_password_screen.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/location_service.dart';
import 'package:nurse/utils/session_manager.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final route;
  const LoginScreen({super.key, this.route});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider = Provider.of<LoginProvider>(context, listen: false);

    getLocationPermission();
    myProvider.clearValues();
    if (SessionManager.keepMySignedIn) {
      myProvider.emailController.text = SessionManager.userEmail;
      myProvider.passwordController.text = SessionManager.userPassword;
      myProvider.isKeepSigned = SessionManager.keepMySignedIn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.whiteColor,
        appBar: appBar(title: getTranslated('logIn', context)!.tr),
        body: Consumer<LoginProvider>(builder: (context, myProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 71, left: 20, right: 20),
            child: Form(
              key: myProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getText(
                      title: getTranslated('email', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    isReadOnly: myProvider.isLoading,

                    /// if api is calling
                    controller: myProvider.emailController,
                    hintText: getTranslated('enterYourEmail', context)!.tr,
                    errorMsg: myProvider.emailValidationMsg,
                    onChanged: (val) {
                      myProvider.emailValidationMsg =
                          AppValidation.emailValidator(val);
                      setState(() {});
                    },
                  ),
                  ScreenSize.height(25),
                  getText(
                      title: getTranslated('password', context)!.tr,
                      size: 14,
                      fontFamily: FontFamily.poppinsSemiBold,
                      color: AppColor.textBlackColor,
                      fontWeight: FontWeight.w500),
                  ScreenSize.height(5),
                  CustomTextfield(
                    controller: myProvider.passwordController,
                    isReadOnly: myProvider.isLoading,

                    /// if api is calling
                    hintText: getTranslated('enterYourPasword', context)!.tr,
                    isObscureText: myProvider.isVisiblePassword,
                    errorMsg: myProvider.passwordValidationMsg,
                    onChanged: (val) {
                      myProvider.passwordValidationMsg =
                          AppValidation.passwordValidator(val);
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
                      ),
                    ),
                  ),
                  ScreenSize.height(31),
                  Row(
                    children: [
                      customRadioButton(myProvider),
                      ScreenSize.width(9.5),
                      getText(
                          title: getTranslated('keepMeSignIn', context)!.tr,
                          size: 12,
                          fontFamily: FontFamily.poppinsSemiBold,
                          color: AppColor.textBlackColor.withOpacity(.7),
                          fontWeight: FontWeight.w500),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          AppRoutes.pushCupertinoNavigation(
                              const ForgotPasswordScreen());
                        },
                        child: getText(
                            title:
                                "${getTranslated('forgotPassword', context)!.tr}?",
                            size: 14,
                            fontFamily: FontFamily.poppinsBold,
                            color: AppColor.appTheme,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  ScreenSize.height(20),
                           Row(
                    children: [
                      customCheckBox(myProvider),
                      ScreenSize.width(10),
                     Flexible(child: Text.rich(TextSpan(
                       text: "${getTranslated(
                           'iAcceptTheGeneral', context)!
                           .tr} ",style: TextStyle(
                         fontSize: 9, fontFamily: FontFamily.poppinsMedium, color: AppColor.textBlackColor.withOpacity(.7), fontWeight: FontWeight.w500
                     ),children: [
                       TextSpan(
                         recognizer: TapGestureRecognizer()..onTap = () {
                           Utils.openUrl(ApiUrl.termsConditionUrl);
                         },
                         text:"${getTranslated(
                             'ternsCondition', context)!
                             .tr} ",
                           style: TextStyle(
                             decoration: TextDecoration.underline,
                           fontSize: 9, fontFamily: FontFamily.poppinsMedium, color: AppColor.appTheme, fontWeight: FontWeight.w500
                       ),children: [
                         TextSpan(
                           text:  "${getTranslated(
                               'andThe', context)!
                               .tr} ",style: TextStyle(
                             decoration: TextDecoration.none,
                             fontSize: 9, fontFamily: FontFamily.poppinsMedium, color: AppColor.textBlackColor.withOpacity(.7), fontWeight: FontWeight.w500
                         ),children: [
                           TextSpan(
                               recognizer: TapGestureRecognizer()..onTap = () {
                                 Utils.openUrl(ApiUrl.privacyPolicyUrl);
                               },
                             text: getTranslated(
                                 'privacyPolicy', context)!
                                 .tr,
                             style: TextStyle(
                                 decoration: TextDecoration.underline,
                                 fontSize: 9, fontFamily: FontFamily.poppinsMedium, color: AppColor.appTheme, fontWeight: FontWeight.w500
                             )
                           )
                         ]
                         )
                       ]
                       )
                     ]
                     )))
                    ],
                  ),
                  ScreenSize.height(49),
                  AppButton(
                      title: getTranslated('logIn', context)!.tr,
                      height: 54,
                      width: double.infinity,
                      buttonColor: AppColor.appTheme,
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        print(SessionManager.lng);
                        getLocationPermission();
                            myProvider.isLoading
                                ? null
                                : myProvider.checkValidation();

                      }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  customRadioButton(LoginProvider provider) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (provider.isKeepSigned) {
          provider.updateKeepSigned(false);
        } else {
          provider.updateKeepSigned(true);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color:
                provider.isKeepSigned ? AppColor.appTheme : AppColor.whiteColor,
            border: Border.all(color: AppColor.appTheme),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          size: 15,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }

  
  customCheckBox(LoginProvider provider) {
    return GestureDetector(
      onTap: () {
        if (provider.isChecked) {
          provider.updateIsChecked(false);
        } else {
          provider.updateIsChecked(true);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: provider.isChecked ? AppColor.appTheme : AppColor.whiteColor,
            border: Border.all(
                color: provider.isChecked
                    ? AppColor.appTheme
                    : AppColor.textBlackColor.withOpacity(.3)),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 20,
                  color: AppColor.blackColor.withOpacity(.2))
            ]),
        alignment: Alignment.center,
        child: Icon(
          Icons.check,
          size: 15,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }

}
