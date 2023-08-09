import '../controllers/global_controllers/game_controller.dart';
import '../controllers/global_controllers/timer_controller.dart';
import '../services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button_widget.dart';
import '../constants/color_constants.dart';
import '../controllers/pages_controllers/more_controller.dart';
import '../localization/translation_helper.dart';

class DialogHelper {
  static Future showQuitDialog(TimerController timerController) async {
    timerController.pauseControllers();
    await Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      titleStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      middleTextStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      title: '${TranslationHelper.quit}?',
      middleText: TranslationHelper.areYouSureYouWantToQuit,
      cancel: CustomButton(
        onPressed: () {
          Get.close(0);
          timerController.resumeController();
        },
        backgroundColor: Colors.white.withOpacity(1),
        foregroundColor: ColorConstants.deepPurple,
        text: TranslationHelper.no,
      ),
      confirm: CustomButton(
        onPressed: () => Get.close(2),
        backgroundColor: ColorConstants.purple.withOpacity(0.5),
        foregroundColor: ColorConstants.white,
        text: TranslationHelper.yes,
      ),
    );
  }

  static void showTimeIsOverDialog(int score) {
    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      titleStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      middleTextStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      title: TranslationHelper.timeIsOver,
      middleText: '$score',
      confirm: CustomButton(
        onPressed: () => Get.close(2),
        backgroundColor: ColorConstants.purple.withOpacity(0.5),
        foregroundColor: ColorConstants.white,
        text: TranslationHelper.quit,
      ),
    );
  }

  static void showGameIsCompletedDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      titleStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      middleTextStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      title: TranslationHelper.great,
      middleText: TranslationHelper.youCompletedTheGame,
      confirm: CustomButton(
        onPressed: () => Get.close(2),
        backgroundColor: ColorConstants.purple.withOpacity(0.5),
        foregroundColor: ColorConstants.white,
        text: TranslationHelper.quit,
      ),
    );
  }

  static void showCreateNicknameDialog() {
    final textEditingController = TextEditingController();

    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      titleStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      middleTextStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      title: TranslationHelper.createNickname,
      middleText: TranslationHelper.youCompletedTheGame,
      content: TextField(
        autofocus: true,
        cursorColor: ColorConstants.purple,
        controller: textEditingController,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.purple),
          ),
          hintText: TranslationHelper.nickname,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.purple),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        maxLength: 16,
        maxLines: 1,
      ),
      cancel: CustomButton(
        onPressed: () => Get.close(0),
        backgroundColor: Colors.white.withOpacity(1),
        foregroundColor: ColorConstants.deepPurple,
        text: TranslationHelper.cancel,
      ),
      confirm: CustomButton(
        onPressed: () async {
          if (textEditingController.text.isNotEmpty) {
            final nickname = textEditingController.text.trim();
            Get.close(0);
            await FirebaseAuthService().signInAnonymously(nickname: nickname);
            Get.find<MoreController>().update();
            textEditingController.clear();
          }
        },
        backgroundColor: ColorConstants.purple.withOpacity(0.5),
        foregroundColor: ColorConstants.white,
        text: TranslationHelper.ok,
      ),
    );
  }

  static Future<bool> showSquareGameModeDialog() async {
    bool isModePressed = false;

    return await Get.defaultDialog(
      barrierDismissible: true,
      titlePadding: const EdgeInsets.all(20),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
      titleStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
      middleTextStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      title: TranslationHelper.selectMode,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(3, (index) {
          final gridViewMode = index + 3;
          return CustomButton(
            onPressed: () {
              isModePressed = true;
              GameController.instance.gridViewMode = gridViewMode;
              Get.close(0);
            },
            backgroundColor: ColorConstants.orange.withOpacity(0.75),
            foregroundColor: Colors.black,
            text: '$gridViewMode×$gridViewMode',
          );
        }),
      ),
    ).then((value) => isModePressed);
  }
}
