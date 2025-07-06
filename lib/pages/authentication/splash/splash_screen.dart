import 'package:flutter/material.dart';
import 'package:tulsi_hotel/pages/authentication/splash/splash_services.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:sms_autofill/sms_autofill.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultAccentColor,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
              child: ImageUtils.setAssetsImage(
                  path: Drawable.splashScreenLogo, width: 200, height: 150)),
        ));
  }
}
