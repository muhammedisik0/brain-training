import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'square_widget.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    Key? key,
    required this.isTappingDisabled,
    required this.crossAxisCount,
    required this.onTapSquare,
    required this.listOfSquares,
  }) : super(key: key);

  final int crossAxisCount;
  final bool isTappingDisabled;
  final Function(int index) onTapSquare;
  final List listOfSquares;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isTappingDisabled,
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        childAspectRatio: 1,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: padding),
        children: List.generate(
          crossAxisCount * crossAxisCount,
          (index) {
            return SquareWidget(
              onTap: () => onTapSquare(index),
              square: listOfSquares[index],
            );
          },
        ),
      ),
    );
  }

  double get padding {
    switch (crossAxisCount) {
      case 3:
        return Get.size.width * 0.180;
      case 4:
        return Get.size.width * 0.120;
      case 5:
        return Get.size.width * 0.090;
      default:
        return Get.size.width * 0.120;
    }
  }
}
