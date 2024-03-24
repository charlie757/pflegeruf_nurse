import 'package:get/get.dart';
import 'package:nurse/languages/languages_string/english_en.dart';

import 'languages_string/german-de.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': englishEN,
        'de': germanDE,
      };
}
