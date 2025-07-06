import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';

class CustomBadgeIcon extends StatelessWidget {
  final int count;
  final double? width, height;

  CustomBadgeIcon({
    required this.count,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 16,
      height: height ?? 16,
      // decoration: BoxDecoration(
      //   color: Colors.red,
      //   shape: BoxShape.circle,
      // ),
      decoration: AppUtils.getGrayBorderDecoration(
          color: Colors.red, borderWidth: 1, borderColor: Colors.white),
      child: Text(
        '$count',
        style: GoogleFonts.plusJakartaSans(
          textStyle:
              TextStyle(color: Colors.white, fontSize: getTextSize(count)),
        ),
      ),
    );
  }

  double getTextSize(int count) {
    double size = 8;
    if (count > 9) {
      size = 7;
    } else if (count > 99) {
      size = 5;
    }
    return size;
  }
}
