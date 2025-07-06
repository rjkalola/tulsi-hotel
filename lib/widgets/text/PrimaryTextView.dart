import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/colors.dart';

class PrimaryTextView extends StatelessWidget {
  const PrimaryTextView(this.text,
      {super.key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.softWrap,
      this.maxLine,
      this.overflow,
      this.fontStyle});

  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "",
        softWrap: softWrap ?? true,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLine,
        overflow: overflow,
        style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              color: color ?? primaryTextColor,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontSize: fontSize,
              fontStyle: fontStyle),
        ));
  }
}
