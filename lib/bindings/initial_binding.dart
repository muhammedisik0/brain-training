import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';
import '../controllers/global_controllers/timer_controller.dart';
import '../controllers/pages_controllers/games_controller.dart';
import '../controllers/pages_controllers/more_controller.dart';
import '../controllers/top_scores_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainPageController());
    Get.put(TopScoresController());
    Get.put(TimerController());
    Get.put(GamesController());
    Get.put(MoreController());
  }
}
