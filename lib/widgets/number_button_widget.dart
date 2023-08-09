import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({
    Key? key,
    required this.onTap,
    required this.number,
  }) : super(key: key);

  final Function() onTap;
  final num number;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 75,
      minWidth: 75,
      color: Colors.white.withOpacity(0.75),
      highlightColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        '$number',
        style: Get.textTheme.headlineSmall,
      ),
    );
  }
}
