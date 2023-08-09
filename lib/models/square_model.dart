
import '../constants/enum_constants.dart';

class Square {
  Square({
    required this.index,
    required this.color,
    this.isNumbered = false,
  });

  Square.numbered({
    required this.index,
    required this.color,
    this.isNumbered = true,
    required this.number,
  });

  late int index;
  late SquareColor color;
  bool isNumbered;
  late int? number;
}
