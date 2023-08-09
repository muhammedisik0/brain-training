import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants/color_constants.dart';
import '../controllers/global_controllers/game_controller.dart';
import '../controllers/global_controllers/timer_controller.dart';
import '../helpers/dialog_helper.dart';
import '../localization/translation_helper.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
    required this.timerController,
    required this.score,
  }) : super(key: key);

  final TimerController timerController;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8),
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          timeText,
          timer,
        ],
      ),
    );
  }

  Widget get timeText {
    return Text(
      TranslationHelper.time,
      style: Get.textTheme.bodyLarge,
    );
  }

  Widget get timer {
    return Countdown(
      controller: timerController.timeController,
      seconds: timerController.timerDuration,
      build: (_, double time) => Text(
        '$time'.split('.').first,
        style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
      ),
      interval: const Duration(milliseconds: 100),
      onFinished: onFinished,
    );
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: ColorConstants.whiteWithOpacity,
    );
  }

  void onFinished() {
    DialogHelper.showTimeIsOverDialog(score);
    GameController.instance.saveScoreToFirestore(score);
  }
}
