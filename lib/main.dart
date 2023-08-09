import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/initial_binding.dart';
import 'constants/route_constants.dart';
import 'constants/theme.dart';
import 'helpers/status_bar_helper.dart';
import 'localization/localization.dart';
import 'routes/app_pages.dart';
import 'services/local_db_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StatusBarHelper.show();
  await Firebase.initializeApp();
  await GetStorage.init('BrainMax');
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      translations: Localization(),
      locale: LocalDb.isLanguageEnglish ? const Locale('en') : const Locale('tr'),
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: InitialBinding(),
      initialRoute: RouteConstants.initialRoute,
      getPages: AppPages.listOfPages,
      //builder: DevicePreview.appBuilder,
    );
  }
}
