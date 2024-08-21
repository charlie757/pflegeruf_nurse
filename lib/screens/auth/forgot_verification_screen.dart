import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/providers/auth_provider/forgot_verification_provider.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';


class ForgotVerificationScreen extends StatefulWidget {
  final email;
  final route;
  const ForgotVerificationScreen({this.email, this.route});

  @override
  State<ForgotVerificationScreen> createState() =>
      _ForgotVerificationScreenState();
}

class _ForgotVerificationScreenState extends State<ForgotVerificationScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<ForgotVerificationProvider>(context, listen: false);
    myProvider.clearValues();
    myProvider.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(
          title: StringKey.forgotVerification.tr,
        ),
        body: Consumer<ForgotVerificationProvider>(
            builder: (context, myProvider, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 37, right: 37, top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: StringKey.enterOtpReceivedOnEmail.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.poppinsRegular,
                            color: AppColor.textBlackColor.withOpacity(.7),
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: ' ${widget.email}',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.poppinsMedium,
                            color: AppColor.appTheme,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                ScreenSize.height(70),
                customOtpTextfield(myProvider),
                ScreenSize.height(70),
                AppButton(
                    title: StringKey.verify.tr,
                    height: 54,
                    width: double.infinity,
                    buttonColor: AppColor.appTheme,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      myProvider.isLoading
                          ? null
                          : myProvider.checkValidation(widget.email);
                    }),
                ScreenSize.height(40),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              myProvider.resend
                                  ? null
                                  : myProvider.resendApiFunction(widget.email);
                            },
                          text: StringKey.resendCode.tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.textBlackColor.withOpacity(.5),
                            fontWeight: FontWeight.w300,
                          )),
                      TextSpan(
                          text: !myProvider.resend
                              ? " 00:00"
                              : " 00:${myProvider.counter < 10 ? "0${myProvider.counter}" : myProvider.counter.toString()}",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.poppinsSemiBold,
                            color: AppColor.appTheme,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  customOtpTextfield(ForgotVerificationProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            roundedTextField(
                controller: provider.otp1Controller,
                focusNode: provider.controller1Focus,
                showUnderline: provider.showUnderlineOtp1,
                provider: provider,
                onTap: () {
                  /// to disable tap on start and mid on input value
                  provider.otp1Controller.selection = TextSelection.collapsed(
                      offset: provider.otp1Controller.text.length);
                },
                onChanged: (val) {
                  print(val);
                  if (val.length >= 1) {
                    provider.showUnderlineOtp1 = true;
                    FocusScope.of(context)
                        .requestFocus(provider.controller2Focus);
                  } else {
                    provider.showUnderlineOtp1 = false;
                  }
                  setState(() {});
                }),
            roundedTextField(
                controller: provider.otp2Controller,
                focusNode: provider.controller2Focus,
                showUnderline: provider.showUnderlineOtp2,
                provider: provider,
                onTap: () {
                  if (provider.otp1Controller.text.isEmpty) {
                    /// to request the foucs
                    FocusScope.of(context)
                        .requestFocus(provider.controller1Focus);
                  } else {
                    /// to disable tap on start and mid on input value
                    provider.otp2Controller.selection = TextSelection.collapsed(
                        offset: provider.otp2Controller.text.length);
                  }
                },
                onChanged: (val) {
                  print(val);
                  if (val.isNotEmpty) {
                    provider.showUnderlineOtp2 = true;
                    FocusScope.of(context)
                        .requestFocus(provider.controller3Focus);
                  } else {
                    provider.showUnderlineOtp2 = false;
                    FocusScope.of(context)
                        .requestFocus(provider.controller1Focus);
                  }
                  if (val.isEmpty) {
                    FocusScope.of(context).requestFocus(provider.controller1Focus);
                  }
                  setState(() {});
                }),
            roundedTextField(
                controller: provider.otp3Controller,
                focusNode: provider.controller3Focus,
                showUnderline: provider.showUnderlineOtp3,
                provider: provider,
                onTap: () {
                  if (provider.otp1Controller.text.isEmpty) {
                    FocusScope.of(context)
                        .requestFocus(provider.controller1Focus);
                  } else if (provider.otp2Controller.text.isEmpty) {
                    FocusScope.of(context)
                        .requestFocus(provider.controller2Focus);
                  } else {
                    /// to disable tap on start and mid on input value
                    provider.otp3Controller.selection = TextSelection.collapsed(
                        offset: provider.otp3Controller.text.length);
                  }
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    provider.showUnderlineOtp3 = true;
                    FocusScope.of(context)
                        .requestFocus(provider.controller4Focus);
                  } else {
                    provider.showUnderlineOtp3 = false;
                    FocusScope.of(context)
                        .requestFocus(provider.controller2Focus);
                  }
                  setState(() {});
                }),
            roundedTextField(
                controller: provider.otp4Controller,
                focusNode: provider.controller4Focus,
                showUnderline: provider.showUnderlineOtp4,
                provider: provider,
                onTap: () {
                  if (provider.otp1Controller.text.isEmpty) {
                    FocusScope.of(context)
                        .requestFocus(provider.controller1Focus);
                  } else if (provider.otp2Controller.text.isEmpty) {
                    FocusScope.of(context)
                        .requestFocus(provider.controller2Focus);
                  } else if (provider.otp3Controller.text.isEmpty) {
                    FocusScope.of(context)
                        .requestFocus(provider.controller3Focus);
                  } else {
                    /// to disable tap on start and mid on input value
                    provider.otp4Controller.selection = TextSelection.collapsed(
                        offset: provider.otp4Controller.text.length);
                  }
                },
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    provider.showUnderlineOtp4 = true;
                  } else {
                    provider.showUnderlineOtp4 = false;
                    FocusScope.of(context)
                        .requestFocus(provider.controller3Focus);
                  }
                  setState(() {});
                }),
          ],
        ),
        provider.isError
            ? const Padding(
                padding: EdgeInsets.only(left: 4, top: 5),
                child: getText(
                    title: 'Otp error',
                    size: 12,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w500),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  roundedTextField(
      {required TextEditingController controller,
      required bool showUnderline,
      required ForgotVerificationProvider provider,
      required FocusNode focusNode,
      required ValueChanged<String>? onChanged,
      required Function() onTap}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:
                  provider.isError ? AppColor.redColor : AppColor.whiteColor),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.shadowColor,
                blurRadius: 10)
          ]),
      padding: const EdgeInsets.only(left: 7, right: 7),
      alignment: Alignment.center,
      child: TextFormField(
        focusNode: focusNode,
        enabled: true,
        enableInteractiveSelection: true,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: AppColor.appTheme,
        style: TextStyle(
            fontSize: 18,
            color: AppColor.textBlackColor.withOpacity(.6),
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.poppinsMedium),
        cursorOpacityAnimates: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
            enabledBorder: showUnderline
                ? UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: AppColor.appTheme),
                  )
                : InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: AppColor.appTheme),
            )),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
