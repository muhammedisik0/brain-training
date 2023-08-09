import 'package:get/get.dart';
import 'translations/en.dart';
import 'translations/tr.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en': en,
      'tr': tr,
    };
  }
}
