import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../constants/firebase_constants.dart';
import '../../constants/image_constants.dart';
import '../../constants/route_constants.dart';
import '../../helpers/dialog_helper.dart';
import '../../localization/translation_helper.dart';
import '../../models/category_model.dart';
import '../../models/game_model.dart';
import '../../services/firestore_db_service.dart';
import '../top_scores_controller.dart';

class GamesController extends GetxController {
  late List<GameCategory> listOfCategories;

  @override
  void onInit() {
    super.onInit();
    listOfCategories = [
      memoryCategory,
      speedCategory,
      attentionCategory,
      mathsCategory,
    ];
  }

  TopScoresController get topScoresController => Get.find();

  GameCategory get memoryCategory {
    return GameCategory(
      name: TranslationHelper.memory,
      backgroundColor: ColorConstants.memory,
      listOfGames: [
        Game(
          name: TranslationHelper.markSquares,
          route: RouteConstants.markSquares,
          databasePath: FirebaseConstants.markSquares,
          hasTopScores: false,
          hasGameModes: true,
          image: ImageConstants.markSquares,
        ),
        Game(
          name: TranslationHelper.seriallyMarkSquares,
          route: RouteConstants.seriallyMarkSquares,
          databasePath: FirebaseConstants.seriallyMarkSquares,
          hasTopScores: false,
          hasGameModes: true,
          image: ImageConstants.seriallyMarkSquares,
        ),
      ],
    );
  }

  GameCategory get speedCategory {
    return GameCategory(
      name: TranslationHelper.speed,
      backgroundColor: ColorConstants.speed,
      listOfGames: [
        Game(
          name: TranslationHelper.matchesPrevious,
          route: RouteConstants.matchesPrevious,
          databasePath: FirebaseConstants.matchesPrevious,
          image: ImageConstants.matchesPrevious,
        ),
      ],
    );
  }

  GameCategory get mathsCategory {
    return GameCategory(
      name: TranslationHelper.maths,
      backgroundColor: ColorConstants.maths,
      listOfGames: [
        Game(
          name: TranslationHelper.fourOperations,
          route: RouteConstants.fourOperations,
          databasePath: FirebaseConstants.fourOperations,
          image: ImageConstants.fourOperations,
        ),
        Game(
          name: TranslationHelper.missingNumber,
          route: RouteConstants.missingNumber,
          databasePath: FirebaseConstants.missingNumber,
          image: ImageConstants.missingNumber,
        ),
      ],
    );
  }

  GameCategory get attentionCategory {
    return GameCategory(
      name: TranslationHelper.attention,
      backgroundColor: ColorConstants.attention,
      listOfGames: [
        Game(
          name: TranslationHelper.airplaneDirection,
          route: RouteConstants.airplaneDirection,
          databasePath: FirebaseConstants.airplaneDirection,
          image: ImageConstants.airplaneDirection,
        ),
        Game(
          name: TranslationHelper.whichNumber,
          route: RouteConstants.whichNumber,
          databasePath: FirebaseConstants.whichNumber,
          image: ImageConstants.whichNumber,
        ),
      ],
    );
  }

  Future<void> onPressedGameButton(Game game) async {
    if (game.hasGameModes) {
      bool value = await DialogHelper.showSquareGameModeDialog();
      if (value) Get.toNamed(game.route);
    } else {
      Get.toNamed(game.route);
      setDatabasePath(game.databasePath);
      topScoresController.getPlayers();
    }
  }

  Future<void> onPressedTopScoresButton(Game game) async {
    if (game.hasTopScores) {
      setDatabasePath(game.databasePath);
      await topScoresController.getPlayers();
      Get.toNamed(RouteConstants.topScores);
    }
  }

  void setDatabasePath(String databasePath) {
    FirestoreDbService.instance.docPath = databasePath.replaceAll('-', '');
    FirestoreDbService.instance.colPath = databasePath;
  }
}
