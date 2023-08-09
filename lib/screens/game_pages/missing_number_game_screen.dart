import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../controllers/game_controllers/missing_number_game_controller.dart';
import '../../widgets/game_page_widget.dart';
import '../../widgets/number_button_widget.dart';

class MissingNumberGameScreen extends GetView<MissingNumberGameController> {
  const MissingNumberGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MissingNumberGameController>(builder: (_) {
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
                operation,
                const SizedBox(height: 50),
                choices,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get operation {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Stack(
            children: [
              numbers,
              operator,
            ],
          ),
          result,
        ],
      ),
    );
  }

  Widget get numbers {
    return Column(
      children: [
        Column(
          children: [
            Text(
              '${controller.firstNumber}',
              style: Get.textTheme.headlineMedium,
            ),
            Text(
              '${controller.secondNumber}',
              style: Get.textTheme.headlineMedium,
            ),
          ],
        ),
        const Divider(
          color: Colors.white,
          thickness: 1,
          height: 10,
        ),
      ],
    );
  }

  Widget get operator {
    return Positioned(
      bottom: 5,
      child: Text(
        controller.operator,
        style: Get.textTheme.headlineMedium,
      ),
    );
  }

  Widget get result {
    return Text(
      '${controller.operation.result}',
      style: Get.textTheme.headlineMedium,
    );
  }

  Widget get choices {
    return IgnorePointer(
      ignoring: controller.isPressingDisabled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          controller.listOfChoices.length,
          (index) {
            return NumberButton(
              onTap: () => controller.onTapNumberButton(index),
              number: controller.listOfChoices[index],
            );
          },
        ),
      ),
    );
  }

  BoxDecoration get decoration {
    return const BoxDecoration(color: ColorConstants.maths);
  }
}
