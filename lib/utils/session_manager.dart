import 'package:nurse/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static late final SharedPreferences sharedPrefs;
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static bool get firstTimeOpenApp =>
      sharedPrefs.getBool(Constants.FIRST_TIME_OPEN_APP) ?? false;
  static set setFirstTimeOpenApp(bool value) {
    sharedPrefs.setBool(Constants.FIRST_TIME_OPEN_APP, value);
  }

  static bool get keepMySignedIn =>
      sharedPrefs.getBool(Constants.KEEP_ME_SIGNED_IN) ?? false;
  static set setKeepMySignedIn(bool value) {
    sharedPrefs.setBool(Constants.KEEP_ME_SIGNED_IN, value);
  }

  static String get userEmail =>
      sharedPrefs.getString(Constants.EMAIL_ID) ?? "";
  static set setUserEmail(String value) {
    sharedPrefs.setString(Constants.EMAIL_ID, value);
  }

  static String get userPassword =>
      sharedPrefs.getString(Constants.PASSWORD) ?? "";
  static set setuserPassword(String value) {
    sharedPrefs.setString(Constants.PASSWORD, value);
  }

  static String get token => sharedPrefs.getString(Constants.TOKEN) ?? "";
  static set setToken(String value) {
    sharedPrefs.setString(Constants.TOKEN, value);
  }

  static String get lat => sharedPrefs.getString(Constants.LAT) ?? "";
  static set setLat(String value) {
    sharedPrefs.setString(Constants.LAT, value);
  }

  static String get lng => sharedPrefs.getString(Constants.LNG) ?? "";
  static set setLng(String value) {
    sharedPrefs.setString(Constants.LNG, value);
  }

  static String get fcmToken =>
      sharedPrefs.getString(Constants.FCM_TOKEN) ?? "";
  static set setFcmToken(String value) {
    sharedPrefs.setString(Constants.FCM_TOKEN, value);
  }

  // de
  static String get languageCode =>
      sharedPrefs.getString(Constants.languageCode) ?? "de";
  static set setLanguageCode(String value) {
    sharedPrefs.setString(Constants.languageCode, value);
  }

  static String get countryCode =>
      sharedPrefs.getString(Constants.countryCode) ?? "DE";
  static set setCountryCode(String value) {
    sharedPrefs.setString(Constants.countryCode, value);
  }
}
