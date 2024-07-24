import 'package:flutter/widgets.dart';
import 'package:nurse/config/approutes.dart';
import 'package:nurse/helper/appimages.dart';
import 'package:nurse/languages/string_key.dart';
import 'package:nurse/screens/choose_login_type_screen.dart';
import 'package:get/get.dart';

class OnboardingProvider extends ChangeNotifier {
  List onboardingList = [
    {
      'img': AppImages.onboarding1Image,
      'title': StringKey.findYourNurse.tr,
      'subTitle':
          'Simply book your personal caregiver at any location and at any time. as flexible as you daily life. '
    },
    {
      'img': AppImages.onboarding2Image,
      'title': StringKey.chooseBestNurse.tr,
      'subTitle':
          'Your opinion matters!\nWe aim to provide you with the best possible care. Help us by sharing your experiences and feedback'
    },
    {
      'img': AppImages.onboarding3Image,
      'title': StringKey.smartBookingSystem.tr,
      'subTitle':
          'When you make a request, the nearest caregiver is notified. You are helping to protect the environment through reduced travel distances.'
    },
  ];

  int currentIndex = 0;

  updateValues(index) {
    currentIndex = index;
    notifyListeners();
  }

  checkValidation() {
    if (currentIndex < 2) {
      updateValues(currentIndex + 1);
    } else {
      AppRoutes.pushCupertinoNavigation(const ChooseLoginTypeScreen());
    }
  }
}
