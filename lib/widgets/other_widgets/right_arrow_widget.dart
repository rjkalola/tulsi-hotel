import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';

class RightArrowWidget extends StatelessWidget {
  const RightArrowWidget({super.key, this.size, this.color});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: size ?? 15,
      height: size ?? 15,
      Drawable.rightArrowItem,
      colorFilter:
          ColorFilter.mode(color ?? defaultAccentColor, BlendMode.srcIn),
    );
  }
}
