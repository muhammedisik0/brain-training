import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePageItemButton extends StatelessWidget {
  const MorePageItemButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 60,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 20),
              Text(
                text,
                style: Get.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
