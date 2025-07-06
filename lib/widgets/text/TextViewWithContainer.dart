import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextViewWithContainer extends StatelessWidget {
  TextViewWithContainer(
      {super.key,
      this.boxColor,
      this.borderRadius,
      this.borderWidth,
      this.borderColor,
      this.boxShadow,
      required this.text,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.padding,
      this.margin,
      this.width,
      this.height,
      this.alignment});

  final String text;
  final Color? fontColor;
  final double? fontSize, width, height;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? boxColor;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding, margin;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: boxColor ?? Colors.transparent,
        boxShadow: boxShadow,
        border: Border.all(
            width: borderWidth ?? 0.6,
            color: borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
      child: Text(text,
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
                color: fontColor,
                fontSize: fontSize ?? 16,
                fontStyle: fontStyle,
                fontWeight: fontWeight ?? FontWeight.w400),
          )),
    );
  }
}
