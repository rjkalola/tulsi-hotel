import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';

import '../../res/colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key,
      this.onValueChange,
      this.onPressedClear,
      this.label,
      this.hint,
      required this.controller,
      required this.isClearVisible,
      this.isReadOnly,
      this.onTap,
      this.autofocus,
      this.focusNode,
      this.padding});

  final ValueChanged<String>? onValueChange;
  final VoidCallback? onPressedClear;
  final Rx<TextEditingController> controller;
  final Rx<bool> isClearVisible;
  final String? label, hint;
  final bool? isReadOnly, autofocus;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: padding ?? EdgeInsets.all(0),
          child: TextField(
            controller: controller.value,
            onChanged: onValueChange,
            readOnly: isReadOnly ?? false,
            autofocus: autofocus ?? false,
            focusNode: focusNode,
            onTap: onTap,
            style: GoogleFonts.inter(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: primaryTextColor)),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              // prefixIcon: const Icon(Icons.search, color: primaryTextColor),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              hintText: hint ?? 'search'.tr,
              labelText: label,
              labelStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey)),
              hintStyle: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey)),
              prefixIcon: Container(
                padding: EdgeInsets.all(14),
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  Drawable.searchLight,
                  width: 12,
                  height: 12,
                ),
              ),

              suffixIcon: isClearVisible.value
                  ? IconButton(
                      onPressed: onPressedClear,
                      icon: const Icon(Icons.cancel),
                    )
                  : Container(
                      width: 1,
                    ),
            ),
          ),
        ));
  }
}
