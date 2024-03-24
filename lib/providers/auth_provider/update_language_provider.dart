import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateLanguageProvider extends ChangeNotifier {
  void setLanguageCode(int index, BuildContext context) async {
    // _languageCode = AppRes.languages[index]['key'];
    await Get.updateLocale(Locale('de'));
    // sessionManager.saveString('LanguageCode', _languageCode);
  }
}
