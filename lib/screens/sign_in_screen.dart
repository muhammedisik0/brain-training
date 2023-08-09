
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../constants/color_constants.dart';
import '../controllers/pages_controllers/more_controller.dart';
import '../helpers/dialog_helper.dart';
import '../localization/translation_helper.dart';
import '../widgets/language_switch_widget.dart';
import '../services/firebase_auth_service.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  MoreController get moreController => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 20,
                child: LanguageSwitch(onChanged: moreController.onPressedLanguage),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  welcomeText,
                  const SizedBox(height: 10),
                  letsStartMakeYourBrainMaxText,
                  const SizedBox(height: 60),
                  continueWithGoogleButton,
                  const SizedBox(height: 20),
                  continueAnonymouslyButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get welcomeText {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        TranslationHelper.welcome,
        style: Get.textTheme.headlineLarge!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget get letsStartMakeYourBrainMaxText {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        TranslationHelper.continueToStartPlayingEntertainingAndImprovingGames,
        style: Get.textTheme.bodyLarge!.copyWith(color: Colors.black),
      ),
    );
  }

  Widget get continueWithGoogleButton {
    return MaterialButton(
      onPressed: FirebaseAuthService().signInWithGoogle,
      height: 60,
      color: ColorConstants.purple,
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.google,
            color: ColorConstants.orange,
          ),
          Expanded(
            child: Center(
              child: Text(
                TranslationHelper.continueWithGoogle,
                style: Get.textTheme.bodyLarge!.copyWith(
                  color: ColorConstants.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get continueAnonymouslyButton {
    return MaterialButton(
      onPressed: DialogHelper.showCreateNicknameDialog,
      height: 60,
      color: Colors.black87,
      child: Row(
        children: [
          const Icon(
            Icons.person_rounded,
            color: Colors.white,
          ),
          Expanded(
            child: Center(
              child: Text(
                TranslationHelper.continueAnonymously,
                style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
