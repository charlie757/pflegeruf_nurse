import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DashboardProvider extends ChangeNotifier {
  int selectedIndex = 0;
  DateTime? currentBackPressTime;
  bool isPopScope = false;
  bool isAllowLocationPermission = false;

  updateLocationPermission(val){
    isAllowLocationPermission=val;
    notifyListeners();
  }

  updateSelectedIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }

  Future<bool> onWillPop() async {
    // productController.clearProductsValues();
    DateTime now = DateTime.now();

    if (selectedIndex == 0) {
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        EasyLoading.showToast(
          'Press again to exit app',
          toastPosition: EasyLoadingToastPosition.bottom,
        );
        // successSnackBar('Exit', 'Press again to exit app');
        return Future.value(false);
      }
      exit(0);
    } else {
      selectedIndex = 0;
      notifyListeners();
      return true;
    }
  }
}
