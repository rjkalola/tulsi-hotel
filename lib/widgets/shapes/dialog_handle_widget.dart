import 'package:flutter/material.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';

class DialogHandleWidget extends StatelessWidget {
  const DialogHandleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 6,
      decoration: AppUtils.getGrayBorderDecoration(
          color: AppUtils.haxColor("#ADADAD")),
    );
  }
}
