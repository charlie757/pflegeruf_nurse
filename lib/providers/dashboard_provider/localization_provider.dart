import 'package:flutter/material.dart';
import 'package:nurse/utils/constants.dart';
import 'package:nurse/utils/session_manager.dart';

class LocalizationProvider extends ChangeNotifier {
  LocalizationProvider() {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
      Constants.languages[0].languageCode!, Constants.languages[0].countryCode);
  bool _isLtr = true;
  int? _languageIndex;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int? get languageIndex => _languageIndex;

  void setLanguage(Locale locale) {
    _locale = locale;
    _isLtr = _locale.languageCode != 'ar';
    // dioClient!.updateHeader(null, locale.countryCode);
    for (int index = 0; index < Constants.languages.length; index++) {
      if (Constants.languages[index].languageCode == locale.languageCode) {
        print("index${Constants.languages[index].languageCode}");
        _languageIndex = index;
        break;
      }
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  loadCurrentLanguage() async {
    _locale = Locale(
        SessionManager.languageCode.isEmpty
            ? Constants.languages[0].languageCode!
            : SessionManager.languageCode,
        SessionManager.countryCode.isEmpty
            ? Constants.languages[0].countryCode
            : SessionManager.countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < Constants.languages.length; index++) {
      if (Constants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    // notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    SessionManager.setLanguageCode = locale.languageCode;
    SessionManager.setCountryCode = locale.countryCode!;
  }
}
