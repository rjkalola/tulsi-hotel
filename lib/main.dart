import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/splash/splash_screen.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/strings.dart';
import 'package:tulsi_hotel/routes/app_pages.dart';
import 'package:tulsi_hotel/utils/app_storage.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  await Get.put(AppStorage()).initStorage();
  // Get.lazyPut(() => HomeTabController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'app_title'.tr,
      translations: Strings(),
      locale: const Locale('en', 'us'),
      getPages: AppPages.list,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: defaultAccentColor),
          useMaterial3: true,
          dialogBackgroundColor: Colors.white),
      home: UpgradeAlert(
        upgrader: Upgrader(),
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        // or cupertino
        shouldPopScope: () => false,
        showIgnore: false,
        showLater: false,
        showReleaseNotes: false,
        child: const SplashScreen(),
      ),
    );
  }
}
