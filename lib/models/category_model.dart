import 'dart:ui';

import 'game_model.dart';

class GameCategory {
  GameCategory({
    required this.name,
    required this.listOfGames,
    required this.backgroundColor,
  });

  late final String name;
  late final Color backgroundColor;
  late final List<Game> listOfGames;
}
