import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/string_constants.dart';
import '../../services/local_db_service.dart';
import '../main_page_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

import 'games_controller.dart';

class MoreController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Get.updateLocale(locale);
  }

  MainPageController get bottomNavBarController => Get.find();
  GamesController get gamesController => Get.find();

  Locale get locale {
    return LocalDb.isLanguageEnglish ? const Locale('en', 'US') : const Locale('tr', 'TR');
  }

  void onPressedLanguage() async {
    await LocalDb.setLanguage();
    await Get.updateLocale(locale);
    bottomNavBarController.updateAppBarTitle();
    gamesController.onInit();
    update();
  }

  void onPressedSoundEffects() {
    LocalDb.setSoundEffects();
    update();
  }

  void onPressedShareApp() => Share.share(StringConstants.playStoreUrl);

  void onPressedRateApp() {
    LaunchReview.launch(
      androidAppId: StringConstants.packageName,
    );
  }

  void onPressedContactUs() {
    final String email = Uri.encodeComponent(StringConstants.contactEmail);
    final String subject = Uri.encodeComponent('');
    final String body = Uri.encodeComponent('');
    Uri url = Uri.parse('mailto:$email?subject=$subject&body=$body');
    launchUrl(url);
  }
}
