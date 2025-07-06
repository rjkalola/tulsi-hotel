import 'package:flutter/material.dart';
import 'package:tulsi_hotel/res/drawable.dart';
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Drawable.tulsiHotelBlackLogo, // your image path
        width: 150,
        height: 80,
      ),
    );
  }
}
