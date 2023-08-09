import 'dart:async';

import 'package:get/get.dart';

import '../../constants/enum_constants.dart';
import '../../helpers/audio_helper.dart';
import '../../helpers/dialog_helper.dart';
import '../../helpers/random_generator.dart';
import '../../helpers/status_bar_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../localization/translation_helper.dart';
import '../global_controllers/game_controller.dart';
import '../global_controllers/timer_controller.dart';

class WhichNumberGameController extends GetxController {
  int score = 0;

  late QuestionType askedQuestion;
  late List<num> listOfChoices;
  late num answer;
  late String questionType;

  late final List listOfQuestionTypes;

  TimerController get timerController => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    StatusBarHelper.hide();
    listOfQuestionTypes = [
      QuestionType.lowestNegative,
      QuestionType.highestPositive,
      QuestionType.highestNegative,
      QuestionType.lowestPositive,
    ];
    timerController.duration = 60;
    generateQuestion();
    generateChoices();
    generateAnswer();
  }

  @override
  void onClose() {
    timerController.resetControllers();
    StatusBarHelper.show();
    super.onClose();
  }

  void generateQuestion() {
    listOfQuestionTypes.shuffle();
    askedQuestion = listOfQuestionTypes.first;
  }

  void generateChoices() {
    listOfChoices = [];
    listOfChoices.addAll([
      RandomGenerator.generateInt(10) * (-1) - 1,
      RandomGenerator.generateInt(10) * (-1) - 1,
      RandomGenerator.generateInt(10) + 1,
      RandomGenerator.generateInt(10) + 1,
    ]);

    while (listOfChoices[0] == listOfChoices[1]) {
      listOfChoices[0] = RandomGenerator.generateInt(10) * (-1) - 1;
    }

    while (listOfChoices[2] == listOfChoices[3]) {
      listOfChoices[3] = RandomGenerator.generateInt(10);
    }
  }

  void generateAnswer() {
    switch (askedQuestion) {
      case QuestionType.lowestNegative:
        if (listOfChoices[0] < listOfChoices[1]) {
          answer = listOfChoices[0];
        } else {
          answer = listOfChoices[1];
        }
        questionType = TranslationHelper.lowest + ' ' + TranslationHelper.negative;
        break;
      case QuestionType.lowestPositive:
        if (listOfChoices[2] < listOfChoices[3]) {
          answer = listOfChoices[2];
        } else {
          answer = listOfChoices[3];
        }
        questionType = TranslationHelper.lowest + ' ' + TranslationHelper.positive;
        break;
      case QuestionType.highestNegative:
        if (listOfChoices[0] > listOfChoices[1]) {
          answer = listOfChoices[0];
        } else {
          answer = listOfChoices[1];
        }
        questionType = TranslationHelper.highest + ' ' + TranslationHelper.negative;
        break;
      case QuestionType.highestPositive:
        if (listOfChoices[2] > listOfChoices[3]) {
          answer = listOfChoices[2];
        } else {
          answer = listOfChoices[3];
        }
        questionType = TranslationHelper.highest + ' ' + TranslationHelper.positive;
        break;
    }
    listOfChoices.shuffle();
  }

  String get question => TranslationHelper.whichOneIsTheNumber(questionType);

  void onTapNumber(int index) => checkAnswer(index);

  Future<void> checkAnswer(int index) async {
    listOfChoices[index] == answer ? await correct : await wrong;
    generateQuestion();
    generateChoices();
    generateAnswer();
    update();
  }

  Future<void> get correct async {
    score += 10;
    await AudioHelper.correctnessSound;
    ToastMessageHelper.showCorrectnessMessage();
  }

  Future<void> get wrong async {
    score -= 10;
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
