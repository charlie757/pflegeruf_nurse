import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nurse/helper/appbutton.dart';
import 'package:nurse/helper/appcolor.dart';
import 'package:nurse/helper/fontfamily.dart';
import 'package:nurse/helper/getText.dart';
import 'package:nurse/helper/screensize.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<OnboardingProvider>(builder: (context, myProvier, child) {
      return SafeArea(
          child: Column(
        children: [
          AnimatedContainer(
              // color: Colors.red,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
              height: MediaQuery.of(context).size.height / 2.5,
              child: Image.asset(
                  myProvier.onboardingList[myProvier.currentIndex]['img'])),
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.appTheme,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 60, bottom: 40),
                child: Column(
                  children: [
                    getText(
                        title: myProvier.onboardingList[myProvier.currentIndex]
                            ['title'],
                        size: 23,
                        fontFamily: FontFamily.poppinsMedium,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w700),
                    const Spacer(),
                    getText(
                      title: myProvier.onboardingList[myProvier.currentIndex]
                          ['subTitle'],
                      size: 18,
                      fontFamily: FontFamily.poppinsLight,
                      color: AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(myProvier.onboardingList.length,
                            (index) {
                          return myProvier.currentIndex == index
                              ? indicator(false)
                              : indicator(true);
                        })),
                    const Spacer(),
                    AppButton(
                        title: myProvier.currentIndex == 2
                            ? StringKey.getStarted.tr
                            : StringKey.next.tr,
                        height: 54,
                        width: double.infinity,
                        buttonColor: AppColor.whiteColor,
                        textColor: AppColor.blackColor,
                        onTap: () {
                          myProvier.checkValidation();
                        })
                  ],
                )),
          )
        ],
      ));
    }));
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 9.0,
        width: isActive ? 10 : 9.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !isActive
              ? AppColor.whiteColor.withOpacity(.5)
              : AppColor.whiteColor,
        ),
      ),
    );
  }
}
