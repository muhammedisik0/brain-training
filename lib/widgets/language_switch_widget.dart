import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../services/local_db_service.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        tr,
        const Icon(Icons.swap_horiz_rounded),
        en,
        mySwitch,
      ],
    );
  }

  Widget get tr {
    return Ink(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: LocalDb.isLanguageEnglish ? Colors.transparent : ColorConstants.purple,
      ),
      child: Text(
        'TR',
        style: LocalDb.isLanguageEnglish
            ? Get.textTheme.labelMedium
            : Get.textTheme.labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget get en {
    return Ink(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: LocalDb.isLanguageEnglish ? ColorConstants.purple : Colors.transparent,
      ),
      child: Text(
        'EN',
        style: LocalDb.isLanguageEnglish
            ? Get.textTheme.labelMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500)
            : Get.textTheme.labelMedium,
      ),
    );
  }

  Widget get mySwitch {
    return Switch(
      onChanged: (value) => onChanged(),
      value: LocalDb.isLanguageEnglish,
      activeColor: ColorConstants.purple,
      inactiveThumbColor: ColorConstants.purple,
      inactiveTrackColor: ColorConstants.purple.withOpacity(0.5),
      activeTrackColor: ColorConstants.purple.withOpacity(0.5),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
