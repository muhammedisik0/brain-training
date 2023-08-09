import 'package:get/get.dart';

import '../constants/route_constants.dart';
import '../controllers/game_controllers/airplane_direction_game_controller.dart';
import '../controllers/game_controllers/four_operations_game_controller.dart';
import '../controllers/game_controllers/mark_squares_game_controller.dart';
import '../controllers/game_controllers/matches_previous_game_controller.dart';
import '../controllers/game_controllers/missing_number_game_controller.dart';
import '../controllers/game_controllers/serially_mark_squares_game_controller.dart';
import '../controllers/game_controllers/which_number_game_controller.dart';

class GameBindings implements Bindings {
  GameBindings(this.route);

  final String route;

  @override
  void dependencies() {
    switch (route) {
      case RouteConstants.markSquares:
        Get.put(MarkSquaresGameController());
        break;
      case RouteConstants.seriallyMarkSquares:
        Get.put(SeriallyMarkSquaresGameController());
        break;
      case RouteConstants.matchesPrevious:
        Get.put(MatchesPreviousGameController());
        break;
      case RouteConstants.fourOperations:
        Get.put(FourOperationsGameController());
        break;
      case RouteConstants.missingNumber:
        Get.put(MissingNumberGameController());
        break;
      case RouteConstants.airplaneDirection:
        Get.put(AirplaneDirectionGameController());
        break;
      case RouteConstants.whichNumber:
        Get.put(WhichNumberGameController());
        break;
    }
  }
}
