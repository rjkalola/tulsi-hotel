import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/colors.dart';

class TextFieldBorder extends StatelessWidget {
  const TextFieldBorder(
      {super.key,
      this.textEditingController,
      this.hintText = "",
      this.labelText = "",
      this.validator,
      this.inputFormatters,
      this.cursorColor = defaultAccentColor,
      this.keyboardType,
      this.textInputAction,
      this.isReadOnly,
      this.suffixIcon,
      this.prefixIcon,
      this.maxLines,
      this.maxLength,
      this.textAlignVertical,
      this.autofocus,
      this.textAlign,
      this.onPressed,
      this.onValueChange,
      this.isDense,
      this.autovalidateMode,
      this.focusNode,
      this.onFieldSubmitted,
      this.errorMaxLines});

  final TextEditingController? textEditingController;
  final String? hintText, labelText;
  final MultiValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? cursorColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? isReadOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines, maxLength;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final GestureTapCallback? onPressed;
  final ValueChanged<String>? onValueChange;
  final bool? autofocus, isDense;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPressed,
      autofocus: autofocus ?? false,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onValueChange,
      style: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: primaryTextColor)),
      controller: textEditingController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      maxLength: maxLength,
      textAlignVertical: textAlignVertical,
      textAlign: textAlign ?? TextAlign.start,
      readOnly: isReadOnly ?? false,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        errorMaxLines: errorMaxLines ?? 2,
        isDense: isDense ?? false,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        counterText: "",
        contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: normalTextFieldBorderColor, width: 0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: focusedTextFieldBorderColor, width: 0.8),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: normalTextFieldBorderColor, width: 0.6),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey)),
        hintStyle: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 16, color: Colors.grey)),
      ),
      validator: validator!,
    );
  }
}
