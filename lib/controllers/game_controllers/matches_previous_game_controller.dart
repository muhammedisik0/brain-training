import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';



import '../../constants/image_constants.dart';
import '../../helpers/audio_helper.dart';
import '../../helpers/random_generator.dart';
import '../../helpers/status_bar_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/planet_model.dart';
import '../top_scores_controller.dart';
import '../global_controllers/timer_controller.dart';

class MatchesPreviousGameController extends GetxController {
  int score = 0;

  late final List<Planet> listOfPlanets;

  late List<String> listOfAnswers;
  final List listOfQuestions = <Planet>[];
  int questionIndex = 0;

  final SwiperController swiperController = SwiperController();

  bool isGameStarted = false;

  TimerController get timerController => Get.find();
  TopScoresController get statsController => Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    StatusBarHelper.hide();
    timerController.duration = 60;
    createListOfPlanets();
    generateAnswers();
    generateQuestions();
  }

  @override
  void onClose() {
    timerController.resetControllers();
    StatusBarHelper.show();
    super.onClose();
  }

  void createListOfPlanets() {
    listOfPlanets = [
      Planet(id: 'Earth', imagePath: ImageConstants.earth),
      Planet(id: 'Mars', imagePath: ImageConstants.mars),
      Planet(id: 'Jupiter', imagePath: ImageConstants.jupiter),
      Planet(id: 'Neptune', imagePath: ImageConstants.neptune),
    ];
  }

  void generateAnswers() {
    listOfAnswers = List.filled(200, 'N');
    for (int i = 0; i < 200; i++) {
      final changeValue = RandomGenerator.generateBool();
      if (i < 2) {
        if (changeValue) listOfAnswers[i] = 'Y';
      } else {
        if (changeValue) {
          if (listOfAnswers[i - 2] != 'Y' || listOfAnswers[i - 1] != 'Y') {
            listOfAnswers[i] = 'Y';
          }
        } else {
          if (listOfAnswers[i - 2] == 'N' && listOfAnswers[i - 1] == 'N') {
            listOfAnswers[i] = 'Y';
          }
        }
      }
    }
  }

  void generateQuestions() {
    var planet = generatePlanet();
    listOfQuestions.add(planet);
    for (int i = 0; i < 200; i++) {
      planet = generatePlanet();
      final Planet previousPlanet = listOfQuestions[i];
      if (listOfAnswers[i] == 'N') {
        while (planet.id == previousPlanet.id) {
          planet = generatePlanet();
        }
        listOfQuestions.add(planet);
      } else {
        listOfQuestions.add(previousPlanet);
      }
    }
  }

  Planet generatePlanet() {
    final randomIndex = RandomGenerator.generateInt(listOfPlanets.length);
    return listOfPlanets[randomIndex];
  }

  String getImagePath(int index) => listOfQuestions[index].imagePath;

  void updateIndex(int value) => questionIndex = value;

  void onTapNoButton() {
    checkAnswer();
    swiperController.next();
  }

  void onTapYesButton() {
    checkAnswer(isNoButtonTapped: false);
    swiperController.next();
  }

  Future<void> checkAnswer({bool isNoButtonTapped = true}) async {
    final answer = listOfAnswers[questionIndex - 1];
    if (answer == 'N') {
      isNoButtonTapped ? correct : wrong;
    } else {
      isNoButtonTapped ? wrong : correct;
    }
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
    swiperController.next();
    timerController.timeController.start();
    update();
  }
}
