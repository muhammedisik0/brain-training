import 'package:get/get.dart';

import '../bindings/game_bindings.dart';
import '../constants/route_constants.dart';
import '../screens/auth_control_screen.dart';
import '../screens/game_pages/airplane_direction_game_screen.dart';
import '../screens/game_pages/four_operations_game_screen.dart';
import '../screens/game_pages/mark_sqaures_game_screen.dart';
import '../screens/game_pages/matches_previous_game_screen.dart';
import '../screens/game_pages/missing_number_game_screen.dart';
import '../screens/game_pages/serially_mark_squares_game_screen.dart';
import '../screens/game_pages/which_number_game_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/top_scores_table_screen.dart';

class AppPages {
  static final List<GetPage> listOfPages = [
    GetPage(
      name: RouteConstants.initialRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteConstants.authControl,
      page: () => const AuthControlScreen(),
    ),
    GetPage(
      name: RouteConstants.topScores,
      page: () => const TopScoresTableScreen(),
    ),
    GetPage(
      name: RouteConstants.markSquares,
      page: () => const MarkSquaresGameScreen(),
      binding: GameBindings(RouteConstants.markSquares),
    ),
    GetPage(
      name: RouteConstants.seriallyMarkSquares,
      page: () => const SeriallyMarkSquaresGameScreen(),
      binding: GameBindings(RouteConstants.seriallyMarkSquares),
    ),
    GetPage(
      name: RouteConstants.matchesPrevious,
      page: () => const MatchesPreviousGameScreen(),
      binding: GameBindings(RouteConstants.matchesPrevious),
    ),
    GetPage(
      name: RouteConstants.fourOperations,
      page: () => const FourOperationsGameScreen(),
      binding: GameBindings(RouteConstants.fourOperations),
    ),
    GetPage(
      name: RouteConstants.missingNumber,
      page: () => const MissingNumberGameScreen(),
      binding: GameBindings(RouteConstants.missingNumber),
    ),
    GetPage(
      name: RouteConstants.airplaneDirection,
      page: () => const AirplaneDirectionGameScreen(),
      binding: GameBindings(RouteConstants.airplaneDirection),
    ),
    GetPage(
      name: RouteConstants.whichNumber,
      page: () => const WhichNumberGameScreen(),
      binding: GameBindings(RouteConstants.whichNumber),
    ),
  ];
}
