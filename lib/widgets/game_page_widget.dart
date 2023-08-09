import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import '../controllers/global_controllers/timer_controller.dart';

import '../helpers/dialog_helper.dart';
import 'countdown_widget.dart';
import 'pause_button_widget.dart';
import 'score_widget.dart';
import 'timer_widget.dart';

class GamePageWidget extends GetView<TimerController> {
  const GamePageWidget({
    Key? key,
    this.decoration = const BoxDecoration(color: ColorConstants.purple),
    this.score = 0,
    this.withScore = true,
    required this.countdownOnFinished,
    required this.children,
  }) : super(key: key);

  const GamePageWidget.withoutScore({
    Key? key,
    this.decoration = const BoxDecoration(color: ColorConstants.purple),
    required this.children,
    required this.countdownOnFinished,
    this.withScore = false,
    this.score,
  }) : super(key: key);

  final BoxDecoration decoration;
  final Function() countdownOnFinished;
  final int? score;
  final List<Widget> children;
  final bool withScore;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await DialogHelper.showQuitDialog(controller),
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: decoration,
        child: Stack(
          alignment: Alignment.center,
          children: [
            pauseButton,
            withScore ? timeAndScoreSection : const SizedBox.shrink(),
            countdownSection,
            ...children,
          ],
        ),
      ),
    );
  }

  Widget get pauseButton {
    return const Positioned(
      top: 0,
      left: 20,
      child: PauseButton(),
    );
  }

  Widget get timeAndScoreSection {
    return Positioned(
      top: 0,
      right: 20,
      child: Row(
        children: [
          timeSection,
          const SizedBox(width: 10),
          scoreSection,
        ],
      ),
    );
  }

  Widget get countdownSection {
    return Positioned(
      top: 100,
      child: CountdownWidget(
        timerController: controller,
        onFinished: countdownOnFinished,
      ),
    );
  }

  Widget get timeSection {
    return TimerWidget(
      timerController: controller,
      score: score!,
    );
  }

  Widget get scoreSection => Score(score: score!);
}
