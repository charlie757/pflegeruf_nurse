import 'package:flutter/material.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:nurse/utils/session_manager.dart';

class ChooseLoginTypeScreen extends StatefulWidget {
  const ChooseLoginTypeScreen({super.key});

  @override
  State<ChooseLoginTypeScreen> createState() => _ChooseLoginTypeScreenState();
}

class _ChooseLoginTypeScreenState extends State<ChooseLoginTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appTheme,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: Image.asset(AppImages.onlineDoctorImage),
              ),
              ScreenSize.height(32),
              getText(
                  title: StringKey.letsGetIn.tr,
                  size: 22,
                  fontFamily: FontFamily.poppinsSemiBold,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w600),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 37, right: 37),
                child: AppButton(
                    title: StringKey.logIn.tr,
                    height: 54,
                    width: double.infinity,
                    buttonColor: AppColor.whiteColor,
                    textColor: AppColor.blackColor,
                    onTap: () {
                      SessionManager.setFirstTimeOpenApp = true;
                      AppRoutes.pushCupertinoNavigation(const LoginScreen());
                    }),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
