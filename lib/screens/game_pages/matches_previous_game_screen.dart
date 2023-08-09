import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image_constants.dart';
import '../../widgets/game_page_widget.dart';
import '../../widgets/yes_no_button_widget.dart';
import '../../controllers/game_controllers/matches_previous_game_controller.dart';
import '../../localization/translation_helper.dart';

class MatchesPreviousGameScreen extends GetView<MatchesPreviousGameController> {
  const MatchesPreviousGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MatchesPreviousGameController>(builder: (_) {
      return Scaffold(body: body);
    });
  }

  Widget get body {
    return GamePageWidget(
      decoration: decoration,
      countdownOnFinished: controller.countdownOnFinished,
      score: controller.score,
      children: [
        planets,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: controller.timerController.isCountdownCompleted,
            child: Column(
              children: [
                doesThisMatchThePreviousText,
                const SizedBox(height: 60),
                buttons,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get planets {
    return SizedBox(
      height: 180,
      child: IgnorePointer(
        ignoring: true,
        child: Swiper(
          onIndexChanged: controller.updateIndex,
          itemBuilder: (_, int index) => Image.asset(controller.getImagePath(index)),
          itemCount: controller.listOfQuestions.length,
          controller: controller.swiperController,
        ),
      ),
    );
  }

  Widget get doesThisMatchThePreviousText {
    return AutoSizeText(
      TranslationHelper.doesThisMatchThePrevious,
      style: Get.textTheme.bodyLarge!.copyWith(fontSize: 20),
      textAlign: TextAlign.center,
      maxLines: 1,
    );
  }

  Widget get buttons {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: YesNoButton(
              onTap: controller.onTapNoButton,
              text: TranslationHelper.no,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: YesNoButton(
              onTap: controller.onTapYesButton,
              text: TranslationHelper.yes,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration get decoration {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(ImageConstants.bgMatchesPrevious),
        fit: BoxFit.cover,
      ),
    );
  }
}
