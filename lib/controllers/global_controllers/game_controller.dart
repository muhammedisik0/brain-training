import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/firestore_db_service.dart';
import '../top_scores_controller.dart';

class GameController {
  GameController._();

  static final instance = GameController._();

  int? _gridViewMode;

  set gridViewMode(value) => _gridViewMode = value;

  get gridViewMode => _gridViewMode;

  int get lastStage {
    switch (_gridViewMode) {
      case 3:
        return 6;
      case 4:
        return 9;
      case 5:
        return 12;
      default:
        return 9;
    }
  }

  bool _isFourOperationsGamePressed = true;

  set isFourOperationsGamePressed(value) => _isFourOperationsGamePressed = value;

  get isFourOperationsGamePressed => _isFourOperationsGamePressed;

  final TopScoresController statsController = Get.find();

  Future<void> saveScoreToFirestore(int score) async {
    final User? user = await statsController.user;
    if (user == null) {
      FirestoreDbService.instance.setData(
        User(
          username: FirebaseAuthService().user!.displayName!,
          score: score,
        ).toJson(),
      );
    } else {
      final previousScore = user.score;
      if (score > previousScore) {
        FirestoreDbService.instance.setData(
          User(
            username: FirebaseAuthService().user!.displayName!,
            score: score,
          ).toJson(),
        );
      }
    }
  }
}
