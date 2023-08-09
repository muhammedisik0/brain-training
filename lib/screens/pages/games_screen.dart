import 'package:brain_training/localization/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/game_button_widget.dart';
import '../../widgets/text_with_divider_widget.dart';
import '../../controllers/pages_controllers/games_controller.dart';

class GamesScreen extends GetView<GamesController> {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          listViewWidget,
          newGamesWillBeAddedText,
        ],
      ),
    );
  }

  Widget get listViewWidget {
    return ListView.separated(
      itemBuilder: (_, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildCategoryName(index),
            const SizedBox(height: 30),
            buildGames(index),
          ],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 30),
      itemCount: controller.listOfCategories.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
    );
  }

  Widget buildCategoryName(int index) {
    return TextWithDivider(
      text: controller.listOfCategories[index].name,
      textStyle: Get.textTheme.titleLarge!.copyWith(color: Colors.black),
    );
  }

  Widget buildGames(int index) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        controller.listOfCategories[index].listOfGames.length,
        (gameIndex) {
          return GameButton(
            game: controller.listOfCategories[index].listOfGames[gameIndex],
            color: controller.listOfCategories[index].backgroundColor,
          );
        },
      ),
    );
  }

  Widget get newGamesWillBeAddedText {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Text(
        TranslationHelper.newGamesWillBeAdded,
        style: Get.textTheme.titleMedium!,
      ),
    );
  }
}
