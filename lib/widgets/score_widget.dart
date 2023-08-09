import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../localization/translation_helper.dart';

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8),
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TranslationHelper.score,
            style: Get.textTheme.bodyLarge,
          ),
          Text(
            '$score',
            style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: ColorConstants.whiteWithOpacity,
    );
  }
}
