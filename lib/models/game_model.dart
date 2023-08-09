class Game {
  Game({
    required this.name,
    required this.route,
    required this.databasePath,
    this.hasTopScores = true,
    this.hasGameModes = false,
    required this.image,
  });

  late final String name;
  late final String route;
  late final String databasePath;
  bool hasTopScores;
  bool hasGameModes;
  late final String image;
}
