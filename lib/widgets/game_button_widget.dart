import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../controllers/pages_controllers/games_controller.dart';
import '../models/game_model.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    Key? key,
    required this.game,
    required this.color,
  }) : super(key: key);

  final Game game;
  final Color color;

  GamesController get gamesController => Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gamesController.onPressedGameButton(game),
      child: Container(
        width: Get.size.width * 0.5 - 30,
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: decoration,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            image,
            name,
            Positioned(
              top: 0,
              right: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  topScoresButton,
                  game.hasTopScores ? const SizedBox.shrink() : slashIcon,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get image {
    return Positioned(
      top: 0,
      child: Image.asset(
        game.image,
        width: 64,
      ),
    );
  }

  Widget get name {
    return AutoSizeText(
      game.name,
      style: Get.textTheme.titleSmall!,
      maxLines: 1,
    );
  }

  Widget get topScoresButton {
    return CircleAvatar(
      backgroundColor: ColorConstants.orange.withOpacity(0.75),
      child: IconButton(
        onPressed: () => gamesController.onPressedTopScoresButton(game),
        icon: const Icon(
          Icons.format_list_numbered_outlined,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget get slashIcon {
    return const FaIcon(
      FontAwesomeIcons.slash,
      color: Colors.white,
    );
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
      /*image: const DecorationImage(
        image: AssetImage(ImageConstants.connection),
        fit: BoxFit.cover,
      ),*/
    );
  }
}
