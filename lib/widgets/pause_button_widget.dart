
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../controllers/global_controllers/timer_controller.dart';
import '../helpers/audio_helper.dart';
import '../helpers/dialog_helper.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  TimerController get timerController => Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(8),
        child: const Icon(
          Icons.pause_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: ColorConstants.whiteWithOpacity,
    );
  }

  void onPressed() {
    timerController.pauseControllers();
    AudioHelper.stopSound;
    DialogHelper.showQuitDialog(timerController);
  }
}
