import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/colors.dart';

class TitleTextView extends StatelessWidget {
  const TitleTextView(this.text,
      {super.key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.textAlign,
      this.softWrap,
      this.maxLine});

  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      softWrap: softWrap ?? true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLine,
      style: GoogleFonts.plusJakartaSans(
        textStyle: TextStyle(
          color: color ?? primaryTextColor,
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 16,
        ),
      ),
    );
  }
}
