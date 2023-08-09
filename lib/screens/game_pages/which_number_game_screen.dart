import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../widgets/number_button_widget.dart';
import '../../widgets/game_page_widget.dart';
import '../../controllers/game_controllers/which_number_game_controller.dart';

class WhichNumberGameScreen extends GetView<WhichNumberGameController> {
  const WhichNumberGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhichNumberGameController>(builder: (_) {
      return Scaffold(body: body);
    });
  }

  Widget get body {
    return GamePageWidget(
      decoration: decoration,
      countdownOnFinished: controller.countdownOnFinished,
      score: controller.score,
      children: [
        Visibility(
          visible: controller.timerController.isCountdownCompleted,
          replacement: const SizedBox.expand(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                questionText,
                const SizedBox(height: 60),
                choices,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get questionText {
    return AutoSizeText(
      controller.question,
      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 20),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  Widget get choices {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        controller.listOfChoices.length,
        (index) {
          return NumberButton(
            onTap: () => controller.onTapNumber(index),
            number: controller.listOfChoices[index],
          );
        },
      ),
    );
  }

  BoxDecoration get decoration {
    return const BoxDecoration(color: ColorConstants.attention);
  }
}
