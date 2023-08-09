import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../constants/enum_constants.dart';
import '../../helpers/audio_helper.dart';
import '../../helpers/dialog_helper.dart';
import '../../helpers/random_generator.dart';
import '../../helpers/status_bar_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../global_controllers/game_controller.dart';
import '../global_controllers/timer_controller.dart';

class AirplaneDirectionGameController extends GetxController {
  late int airplaneAroundTurns;
  late int airplaneInTheMiddleTurns;
  late AirplanesType airplanesType;
  late List<SwipeDirection> listOfDirections;
  late List<Alignment> listOfAlignments;
  late SwipeDirection airplaneDirection;
  late Alignment airplanesPosition;

  int score = 0;

  TimerController get timerController => Get.find();

  @override
  void onInit() {
    super.onInit();
    StatusBarHelper.hide();
    timerController.duration = 60;

    listOfAlignments = [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
      Alignment.bottomLeft,
      Alignment.bottomCenter,
      Alignment.bottomRight,
    ];

    listOfDirections = [
      SwipeDirection.left,
      SwipeDirection.up,
      SwipeDirection.right,
      SwipeDirection.down,
    ];

    generateQuestion();
  }

  @override
  void onClose() {
    timerController.resetControllers();
    StatusBarHelper.show();
    super.onClose();
  }

  void generateQuestion() {
    determineAirplaneDirection();
    determineAirplanesPosition();
    detectAirplaneDirection();
    determineAirplaneAroundTurns();
    determineAirplanesType();
  }

  void determineAirplaneDirection() {
    listOfDirections.shuffle();
    airplaneDirection = listOfDirections.first;
  }

  void determineAirplanesPosition() {
    listOfAlignments.shuffle();
    airplanesPosition = listOfAlignments.first;
  }

  void detectAirplaneDirection() {
    switch (airplaneDirection) {
      case SwipeDirection.left:
        airplaneDirection = SwipeDirection.left;
        airplaneInTheMiddleTurns = 3;
        break;
      case SwipeDirection.up:
        airplaneDirection = SwipeDirection.up;
        airplaneInTheMiddleTurns = 0;
        break;
      case SwipeDirection.right:
        airplaneDirection = SwipeDirection.right;
        airplaneInTheMiddleTurns = 1;
        break;
      case SwipeDirection.down:
        airplaneDirection = SwipeDirection.down;
        airplaneInTheMiddleTurns = 2;
        break;
    }
  }

  void determineAirplaneAroundTurns() {
    final turns = RandomGenerator.generateInt(4);
    airplaneAroundTurns = turns;
  }

  void determineAirplanesType() {
    final value = RandomGenerator.generateInt(5);
    airplanesType = AirplanesType.values[value];
  }

  Future<void> onSwipe(SwipeDirection direction) async {
    await checkAnswer(direction);
    generateQuestion();
    update();
  }

  Future<void> checkAnswer(SwipeDirection direction) async {
    direction == airplaneDirection ? await correct : await wrong;
  }

  Future<void> get correct async {
    score += 10;
    await AudioHelper.correctnessSound;
    ToastMessageHelper.showCorrectnessMessage();
  }

  Future<void> get wrong async {
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

  void onHorizaontalDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx > 0) {
      onSwipe(SwipeDirection.right);
    } else if (details.velocity.pixelsPerSecond.dx < 0) {
      onSwipe(SwipeDirection.left);
    }
  }

  void onVerticalDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dy > 0) {
      onSwipe(SwipeDirection.down);
    } else if (details.velocity.pixelsPerSecond.dy < 0) {
      onSwipe(SwipeDirection.up);
    }
  }
}
