import 'package:get/get.dart';

import '../constants/enum_constants.dart';
import '../localization/translation_helper.dart';

class MainPageController extends GetxController {
  Pages currentPage = Pages.games;

  String title = TranslationHelper.games;

  void changePageIndex(int index) {
    currentPage = Pages.values[index];
    switch (index) {
      case 0:
        title = TranslationHelper.games;
        break;
      case 1:
        title = TranslationHelper.more;
        break;
    }
    update();
  }

  void updateAppBarTitle() {
    title = TranslationHelper.more;
    update();
  }
}
