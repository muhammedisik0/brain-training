import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';
import '../constants/route_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToAuthControlScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BRAIN',
              style: Get.textTheme.displayMedium!.copyWith(
                color: ColorConstants.orange,
                fontWeight: FontWeight.w500,
                fontFamily: FontConstants.darumadropOne,
              ),
            ),
            Text(
              'MAX',
              style: Get.textTheme.displayMedium!.copyWith(
                color: ColorConstants.orange,
                fontWeight: FontWeight.w500,
                fontFamily: FontConstants.darumadropOne,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> navigateToAuthControlScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offNamed(RouteConstants.authControl);
  }
}
