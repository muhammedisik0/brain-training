import 'dart:async';

import 'package:get/get.dart';

import '../../helpers/audio_helper.dart';
import '../../helpers/dialog_helper.dart';
import '../../helpers/random_generator.dart';
import '../../helpers/status_bar_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/math_operation_model.dart';
import '../global_controllers/game_controller.dart';
import '../global_controllers/timer_controller.dart';

class FourOperationsGameController extends GetxController {
  late MathOperation operation;
  late List<num> listOfChoices;
  late int operationLoop;

  bool isPressingDisabled = false;

  int score = 0;

  TimerController get timerController => Get.find();

  @override
  void onInit() {
    super.onInit();
    StatusBarHelper.hide();
    timerController.duration = 60;
    operation = MathOperation();
    operationLoop = 0;
    generateQuestion();
    generateChoices();
  }

  @override
  void onClose() {
    timerController.resetControllers();
    StatusBarHelper.show();
    super.onClose();
  }

  void generateQuestion() {
    checkIfOperationLoopCompleted();
    operation.setOperator(operationLoop);
    operation.setNumbers();
  }

  void checkIfOperationLoopCompleted() {
    if (operationLoop == 0) {
      operationLoop++;
      operation.shuffleListOfOperators();
    } else if (operationLoop < operation.listOfOperators.length) {
      operationLoop++;
    } else {
      operationLoop = 0;
      checkIfOperationLoopCompleted();
    }
  }

  String get operator => operation.operator.replaceAll('*', '×').replaceAll('/', '÷');

  void generateChoices() {
    listOfChoices = [];
    listOfChoices.addAll([
      operation.result,
      operation.result - RandomGenerator.generateInt(10) - 1,
      operation.result + RandomGenerator.generateInt(10) + 1,
    ]);
    listOfChoices.shuffle();
  }

  Future<void> onTapNumberButton(int index) async {
    isPressingDisabled = true;
    checkAnswer(index);
    generateQuestion();
    generateChoices();
    isPressingDisabled = false;
    update();
  }

  Future<void> checkAnswer(int index) async {
    listOfChoices[index] == operation.result ? await correct : await wrong;
  }

  Future<void> get correct async {
    score += 10;
    await AudioHelper.correctnessSound;
    ToastMessageHelper.showCorrectnessMessage();
  }

  Future<void> get wrong async {
    score -= 5;
    await AudioHelper.wrongfulnessSound;
    ToastMessageHelper.showWrongfullnessMessage();
  }

  void countdownOnFinished() {
    timerController.timeController.start();
    update();
  }

  void timerOnFinished() {
    DialogHelper.showTimeIsOverDialog(score);
    GameController.instance.saveScoreToFirestore(score);
  }
}
