import 'package:flutter/material.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryTextView(
        "Welcome 👋",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: defaultAccentColor,
        fontStyle: FontStyle.italic,
        textAlign: TextAlign.left,
      ),
    );
  }
}
