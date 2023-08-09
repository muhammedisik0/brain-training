import 'package:flutter_svg/flutter_svg.dart';
import 'package:x_message/x_message.dart';
import '../constants/image_constants.dart';
import 'context_helper.dart';

class ToastMessageHelper {
  static void show(String imagePath) {
    Toast(
      context: ContextHelper.instance.context,
      child: SvgPicture.asset(imagePath, width: 60),
      position: ToastPosition.center,
      duration: const Duration(milliseconds: 500),
    );
  }

  static void showCorrectnessMessage() => show(ImageConstants.correctnessIcon);

  static void showWrongfullnessMessage() => show(ImageConstants.wrongfulnessIcon);
}
