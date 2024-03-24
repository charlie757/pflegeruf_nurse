import 'dart:io';

class AppRes {
  static String selectedLanguage = Platform.localeName.split('_')[0];

  static List<Map<String, dynamic>> languages = [
    {
      'title': 'عربي',
      'subHeading': 'Arabic',
      'key': 'ar',
    },
    {
      'title': 'dansk',
      'subHeading': 'Danish',
      'key': 'da',
    },
    {
      'title': 'Nederlands',
      'subHeading': 'Dutch',
      'key': 'nl',
    },
    {
      'title': 'English',
      'subHeading': 'English',
      'key': 'en',
    },
    {
      'title': 'Français',
      'subHeading': 'French',
      'key': 'fr',
    },
    {
      'title': 'Deutsch',
      'subHeading': 'German',
      'key': 'de',
    },
    {
      'title': 'Ελληνικά',
      'subHeading': 'Greek',
      'key': 'el',
    },
    {
      'title': 'हिंदी',
      'subHeading': 'Hindi',
      'key': 'hi',
    },
    {
      'title': 'bahasa Indonesia',
      'subHeading': 'Indonesian',
      'key': 'id',
    },
    {
      'title': 'Italiano',
      'subHeading': 'Italian',
      'key': 'it',
    },
    {
      'title': '日本',
      'subHeading': 'Japanese',
      'key': 'ja',
    },
    {
      'title': '한국인',
      'subHeading': 'Korean',
      'key': 'ko',
    },
    {
      'title': 'Norsk Bokmal',
      'subHeading': 'Norwegian Bokmal',
      'key': 'nb',
    },
    {
      'title': 'Polski',
      'subHeading': 'Polish',
      'key': 'pl',
    },
    {
      'title': 'Português',
      'subHeading': 'Portuguese',
      'key': 'pt',
    },
    {
      'title': 'Русский',
      'subHeading': 'Russian',
      'key': 'ru',
    },
    {
      'title': '简体中文',
      'subHeading': 'Simplified Chinese',
      'key': 'zh',
    },
    {
      'title': 'Español',
      'subHeading': 'Spanish',
      'key': 'es',
    },
    {
      'title': 'แบบไทย',
      'subHeading': 'Thai',
      'key': 'th',
    },
    {
      'title': 'Türkçe',
      'subHeading': 'Turkish',
      'key': 'tr',
    },
    {
      'title': 'Tiếng Việt',
      'subHeading': 'Vietnamese',
      'key': 'vi',
    },
  ];
}
