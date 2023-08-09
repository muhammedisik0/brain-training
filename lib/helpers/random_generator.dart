import 'dart:math';


class RandomGenerator {
  static final Random random = Random();

  static int generateInt(int max) {
    return random.nextInt(max);
  }

  static bool generateBool() {
    return random.nextBool();
  }
}
