import 'package:flutter/material.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/customtextfield.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/language_constants.dart';
import 'package:nurse/providers/auth_provider/change_password_provider.dart';
import 'package:nurse/utils/app_validation.dart';
import 'package:nurse/utils/utils.dart';
import 'package:nurse/widgets/appBar.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  final email;
  final verificationCode;
  const ChangePasswordScreen({super.key, this.email, this.verificationCode});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final myProvider =
        Provider.of<ChangePasswordProvider>(context, listen: false);
    myProvider.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          resizeToAvoidBottomInset: false,
          appBar: appBar(title: getTranslated('changePassword', context)!.tr),
          body: Consumer<ChangePasswordProvider>(
              builder: (context, myProvider, child) {
            return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: getText(
                        title: getTranslated('setNewPassword', context)!.tr,
                        size: 12,
                        fontFamily: FontFamily.poppinsRegular,
                        color: AppColor.textBlackColor.withOpacity(.7),
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ScreenSize.height(50),
                    CustomTextfield(
                      controller: myProvider.enterNewPassword,
                      hintText: getTranslated('enterNewPassword', context)!.tr,
                      isReadOnly: myProvider.isLoading,
                      isObscureText: myProvider.isVisibleNewPassword,
                      errorMsg: myProvider.passwordValidationMsg,
                      onChanged: (val) {
                        myProvider.passwordValidationMsg =
                            AppValidation.reEnterpasswordValidator(
                                val, myProvider.reEnterNewPassword.text);
                        setState(() {});
                      },
                      icon: GestureDetector(
                        onTap: () {
                          if (myProvider.isVisibleNewPassword) {
                            myProvider.updateIsVisibleNewPassword(false);
                          } else {
                            myProvider.updateIsVisibleNewPassword(true);
                          }
                        },
                        child: Icon(
                          myProvider.isVisibleNewPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColor.textBlackColor.withOpacity(.3),
                        ),
                      ),
                    ),
                    ScreenSize.height(20),
                    CustomTextfield(
                      controller: myProvider.reEnterNewPassword,
                      hintText:
                          getTranslated('reenternewPassword', context)!.tr,
                      isReadOnly: myProvider.isLoading,
                      isObscureText: myProvider.isVisibleReEnterPassword,
                      errorMsg: myProvider.reEnterPasswordValidationMsg,
                      onChanged: (val) {
                        myProvider.reEnterPasswordValidationMsg =
                            AppValidation.reEnterpasswordValidator(
                                val, myProvider.enterNewPassword.text);
                        setState(() {});
                      },
                      icon: GestureDetector(
                        onTap: () {
                          if (myProvider.isVisibleReEnterPassword) {
                            myProvider.updateIsVisibleReEnterPassword(false);
                          } else {
                            myProvider.updateIsVisibleReEnterPassword(true);
                          }
                        },
                        child: Icon(
                          myProvider.isVisibleReEnterPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColor.textBlackColor.withOpacity(.3),
                        ),
                      ),
                    ),
                    ScreenSize.height(60),
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 17),
                      child: AppButton(
                          title: getTranslated('save', context)!.tr,
                          height: 54,
                          width: double.infinity,
                          buttonColor: AppColor.appTheme,
                          isLoading: myProvider.isLoading,
                          onTap: () {
                            myProvider.checkValidation(
                                widget.email, widget.verificationCode);
                          }),
                    )
                  ],
                ));
          }),
        ),
      ),
    );
  }
}
