import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/colors.dart';

class SubtitleTextView extends StatelessWidget {
  const SubtitleTextView(this.text,
      {super.key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.softWrap,
      this.maxLine,
      this.fontStyle});

  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLine;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "",
        softWrap: softWrap ?? true,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLine,
        style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              color: color ?? secondaryLightTextColor,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontSize: fontSize ?? 14,
              fontStyle: fontStyle),
        ));
  }
}
