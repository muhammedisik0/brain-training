import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor,
      minWidth: 100,
      child: Text(
        text,
        style: Get.textTheme.bodyMedium!.copyWith(color: foregroundColor),
      ),
    );
  }
}
