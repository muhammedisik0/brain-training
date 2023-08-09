import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../constants/enum_constants.dart';
import '../models/square_model.dart';

class SquareWidget extends StatelessWidget {
  const SquareWidget({
    Key? key,
    required this.onTap,
    required this.square,
  }) : super(key: key);

  final Function() onTap;
  final Square square;

  @override
  Widget build(BuildContext context) {
    return square.isNumbered ? numberedSquare : numberlessSquare;
  }

  Widget get numberedSquare {
    return GestureDetector(
      onTap: onTapOrNull,
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: square.number == null
            ? null
            : Text(
                '${square.number}',
                style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
              ),
      ),
    );
  }

  Widget get numberlessSquare {
    return GestureDetector(
      onTap: onTapOrNull,
      child: Container(
        color: color,
        alignment: Alignment.center,
      ),
    );
  }

  get onTapOrNull => square.color == SquareColor.white ? onTap : null;

  Color get color {
    switch (square.color) {
      case SquareColor.white:
        return Colors.white;
      case SquareColor.orange:
        return ColorConstants.orange;
      case SquareColor.green:
        return Colors.greenAccent[400]!;
    }
  }
}
