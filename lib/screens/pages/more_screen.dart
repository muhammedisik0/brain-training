import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../constants/enum_constants.dart';
import '../../controllers/pages_controllers/more_controller.dart';
import '../../localization/translation_helper.dart';
import '../../services/firebase_auth_service.dart';
import '../../services/local_db_service.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/language_switch_widget.dart';
import '../../widgets/more_page_item_button_widget.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                accountInfoSection,
                divider,
                languageSection,
                soundEffectsSection,
                shareAppSection,
                rateAppSection,
                contactUsSection,
                const SizedBox(height: 20),
                versionNumber,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get accountInfoSection {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              userPhoto,
              const SizedBox(height: 20),
              displayName,
            ],
          ),
          const SizedBox(height: 20),
          signOutButton,
        ],
      ),
    );
  }

  Widget get userPhoto {
    switch (FirebaseAuthService().authType) {
      case AuthType.google:
        return networkImage;
      case AuthType.anonymous:
        return circleAvatar;
    }
  }

  Widget get networkImage {
    return CachedNetworkImage(
      width: 80,
      height: 80,
      imageUrl: FirebaseAuthService().user!.photoURL!,
      imageBuilder: (_, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(image: imageProvider),
        ),
      ),
      placeholder: (_, url) => const CircularProgressIndicator(
        color: ColorConstants.orange,
      ),
      errorWidget: (_, url, error) => const Icon(Icons.error),
    );
  }

  Widget get circleAvatar {
    return const CircleAvatar(
      backgroundColor: Colors.black87,
      radius: 40,
      child: Icon(
        Icons.person_rounded,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  Widget get displayName {
    return Text(
      FirebaseAuthService().user!.displayName ?? '...',
      style: Get.textTheme.titleMedium,
    );
  }

  Widget get signOutButton {
    return CustomButton(
      onPressed: () {
        switch (FirebaseAuthService().authType) {
          case AuthType.google:
            FirebaseAuthService().signOut();
            break;
          case AuthType.anonymous:
            FirebaseAuthService().deleteUser();
            break;
        }
      },
      backgroundColor: Colors.redAccent[700]!,
      foregroundColor: Colors.white,
      text: TranslationHelper.signOut,
    );
  }

  Widget get divider {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Divider(
        height: 0,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }

  Widget get languageSection {
    return Stack(
      children: [
        MorePageItemButton(
          onPressed: controller.onPressedLanguage,
          icon: const Icon(Icons.translate_outlined),
          text: TranslationHelper.language,
        ),
        Positioned(
          right: 20,
          top: 0,
          bottom: 0,
          child: LanguageSwitch(onChanged: controller.onPressedLanguage),
        ),
      ],
    );
  }

  Widget get soundEffectsSection {
    return Stack(
      children: [
        MorePageItemButton(
          onPressed: controller.onPressedSoundEffects,
          icon: const Icon(Icons.music_note_outlined),
          text: TranslationHelper.soundEffects,
        ),
        soundEffectsSwitch,
      ],
    );
  }

  Widget get soundEffectsSwitch {
    return Positioned(
      right: 20,
      top: 0,
      bottom: 0,
      child: Switch(
        onChanged: (value) => controller.onPressedSoundEffects(),
        value: LocalDb.isSoundEffectsOn,
        activeColor: ColorConstants.purple,
        inactiveThumbColor: Colors.grey[200],
        inactiveTrackColor: Colors.grey[400],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget get shareAppSection {
    return MorePageItemButton(
      onPressed: controller.onPressedShareApp,
      icon: const Icon(Icons.share_outlined),
      text: TranslationHelper.shareApp,
    );
  }

  Widget get rateAppSection {
    return MorePageItemButton(
      onPressed: controller.onPressedRateApp,
      icon: const Icon(Icons.star_rate_outlined),
      text: TranslationHelper.rateApp,
    );
  }

  Widget get contactUsSection {
    return MorePageItemButton(
      onPressed: controller.onPressedContactUs,
      icon: const Icon(Icons.mail_outlined),
      text: TranslationHelper.contactUs,
    );
  }

  Widget get versionNumber {
    return Text(
      '${TranslationHelper.version} 1.0',
      style: Get.textTheme.labelLarge!.copyWith(color: Colors.grey),
    );
  }
}
