import 'package:flutter/material.dart';

class TextWithDivider extends StatelessWidget {
  const TextWithDivider({
    Key? key,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
        const Expanded(
          child: Divider(
            height: 0,
            thickness: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
