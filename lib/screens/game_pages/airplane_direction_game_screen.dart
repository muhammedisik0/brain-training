import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image_constants.dart';
import '../../controllers/game_controllers/airplane_direction_game_controller.dart';
import '../../widgets/airplanes_widget.dart';
import '../../widgets/game_page_widget.dart';

class AirplaneDirectionGameScreen extends GetView<AirplaneDirectionGameController> {
  const AirplaneDirectionGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AirplaneDirectionGameController>(builder: (_) {
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
          child: GestureDetector(
            onHorizontalDragEnd: controller.onHorizaontalDragEnd,
            onVerticalDragEnd: controller.onVerticalDragEnd,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: Get.size.height - 100,
                color: Colors.transparent,
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 250),
                child: Stack(
                  alignment: controller.airplanesPosition,
                  children: const [
                    Airplanes(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration get decoration {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(ImageConstants.bgAirplaneDirection),
        fit: BoxFit.cover,
      ),
    );
  }
}
