import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../constants/color_constants.dart';
import '../controllers/global_controllers/timer_controller.dart';
import '../helpers/audio_helper.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget({
    Key? key,
    required this.timerController,
    required this.onFinished,
  }) : super(key: key);

  final TimerController timerController;
  final Function() onFinished;

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  @override
  void initState() {
    super.initState();
    AudioHelper.countdownSound;
  }

  @override
  void dispose() {
    AudioHelper.stopSound;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.timerController.isCountdownCompleted,
      child: Countdown(
        controller: widget.timerController.countdownController,
        seconds: widget.timerController.countdownDuration,
        build: (_, double time) {
          return Center(
            child: Text(
              '$time'.substring(0, 1),
              style: Get.textTheme.displaySmall!.copyWith(color: ColorConstants.white),
            ),
          );
        },
        interval: const Duration(seconds: 1),
        onFinished: widget.onFinished,
      ),
    );
  }
}
