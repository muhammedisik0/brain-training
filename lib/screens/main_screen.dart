import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants/enum_constants.dart';
import '../controllers/main_page_controller.dart';
import '../helpers/context_helper.dart';
import '../localization/translation_helper.dart';
import 'pages/games_screen.dart';
import 'pages/more_screen.dart';

class MainScreen extends GetView<MainPageController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContextHelper.instance.context = context;
    return GetBuilder<MainPageController>(builder: (_) {
      return Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: true,
      );
    });
  }

  AppBar get appBar {
    return AppBar(
      title: Text(controller.title),
      automaticallyImplyLeading: false,
      titleSpacing: 20,
    );
  }

  Widget get body {
    switch (controller.currentPage) {
      case Pages.games:
        return const GamesScreen();
      case Pages.more:
        return const MoreScreen();
    }
  }

  Widget get bottomNavigationBar {
    return Container(
      decoration: decoration,
      child: BottomNavigationBar(
        onTap: controller.changePageIndex,
        currentIndex: controller.currentPage.index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(FontAwesomeIcons.gamepad),
            label: TranslationHelper.games,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.more_horiz),
            label: TranslationHelper.more,
          ),
        ],
      ),
    );
  }

  BoxDecoration get decoration {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey[600]!,
          blurRadius: 4,
        ),
      ],
    );
  }
}
