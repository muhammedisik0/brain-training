import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YesNoButton extends StatelessWidget {
  const YesNoButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 80,
      color: Colors.white.withOpacity(0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: Get.textTheme.titleLarge,
      ),
    );
  }
}
