import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../widgets/game_page_widget.dart';
import '../../widgets/grid_view_widget.dart';
import '../../controllers/game_controllers/mark_squares_game_controller.dart';

class MarkSquaresGameScreen extends GetView<MarkSquaresGameController> {
  const MarkSquaresGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkSquaresGameController>(builder: (_) {
      return Scaffold(body: body);
    });
  }

  Widget get body {
    return GamePageWidget.withoutScore(
      decoration: decoration,
      countdownOnFinished: controller.countdownOnFinished,
      children: [
        nthStageText,
        gridView,
      ],
    );
  }

  Widget get nthStageText {
    return Positioned(
      top: 100,
      child: Visibility(
        visible: controller.timerController.isCountdownCompleted,
        child: Text(
          controller.nthStageText,
          style: Get.textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget get gridView {
    return Center(
      child: GridViewWidget(
        isTappingDisabled: controller.isTappingDisabled,
        crossAxisCount: controller.gridViewMode,
        listOfSquares: controller.listOfSquares,
        onTapSquare: controller.onTapSquare,
      ),
    );
  }

  BoxDecoration get decoration {
    return const BoxDecoration(color: ColorConstants.memory);
  }
}
