
import 'package:get/get.dart';

import '../../constants/enum_constants.dart';
import '../../helpers/audio_helper.dart';
import '../../helpers/dialog_helper.dart';
import '../../helpers/status_bar_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/square_model.dart';
import '../global_controllers/game_controller.dart';
import '../global_controllers/timer_controller.dart';

class SeriallyMarkSquaresGameController extends GetxController {
  late List<Square> listOfSquares;
  late List<int> listOfRandomIndexes;

  int numberOfCorrectMarks = 0;
  int nthStage = 3;

  bool isTappingDisabled = true;

  TimerController get timerController => Get.find();

  @override
  void onInit() {
    super.onInit();
    StatusBarHelper.hide();
    resetSquares();
  }

  @override
  void onClose() {
    timerController.resetControllers();
    StatusBarHelper.show();
    super.onClose();
  }

  Future<void> generateQuestion() async {
    resetSquares();
    generateRandomIndexes();
    await showSquares();
    hideSquares();
  }

  int get gridViewMode => GameController.instance.gridViewMode;

  void generateRandomIndexes() {
    listOfRandomIndexes = List.generate(
      gridViewMode * gridViewMode,
      (index) => index,
    );
    listOfRandomIndexes.shuffle();
    listOfRandomIndexes = listOfRandomIndexes.sublist(0, nthStage);
  }

  void resetSquares() {
    listOfSquares = List.generate(
      gridViewMode * gridViewMode,
      (index) => Square.numbered(
        index: index,
        color: SquareColor.white,
        number: null,
      ),
    );
    numberOfCorrectMarks = 0;
    update();
  }

  Future<void> showSquares() async {
    isTappingDisabled = true;
    for (int element in listOfRandomIndexes) {
      listOfSquares[element].color = SquareColor.orange;
      await Future.delayed(const Duration(milliseconds: 600));
      update();
    }
  }

  void hideSquares() {
    isTappingDisabled = false;
    for (int element in listOfRandomIndexes) {
      listOfSquares[element].color = SquareColor.white;
    }
    update();
  }

  void revealSquares() {
    int n = 0;
    for (int element in listOfRandomIndexes) {
      n++;
      if (listOfSquares[element].color != SquareColor.green) {
        listOfSquares[element].color = SquareColor.orange;
        listOfSquares[element].number = n;
        update();
      }
    }
  }

  Future<void> onTapSquare(int index) async {
    await AudioHelper.tapSound;
    if (listOfRandomIndexes[numberOfCorrectMarks] == index) {
      numberOfCorrectMarks++;
      listOfSquares[index].color = SquareColor.green;
      listOfSquares[index].number = numberOfCorrectMarks;
      checkIfStageCompleted();
    } else {
      isTappingDisabled = true;
      AudioHelper.wrongfulnessSound;
      ToastMessageHelper.showWrongfullnessMessage();
      revealSquares();
      await Future.delayed(const Duration(seconds: 2));
      generateQuestion();
    }
    update();
  }

  Future<void> checkIfStageCompleted() async {
    if (numberOfCorrectMarks == nthStage) {
      isTappingDisabled = true;
      await correct;
      checkIfGameCompleted();
    }
  }

  Future<void> checkIfGameCompleted() async {
    nthStage++;
    if (nthStage <= lastStage) {
      await Future.delayed(const Duration(seconds: 1));
      generateQuestion();
    } else {
      DialogHelper.showGameIsCompletedDialog();
    }
  }

  Future<void> get correct async {
    await AudioHelper.correctnessSound;
    ToastMessageHelper.showCorrectnessMessage();
  }

  Future<void> get wrong async {
    await AudioHelper.wrongfulnessSound;
    ToastMessageHelper.showWrongfullnessMessage();
  }

  void countdownOnFinished() {
    generateQuestion();
    update();
  }

  int get lastStage => GameController.instance.lastStage;

  String get nthStageText => '$nthStage / $lastStage';
}
