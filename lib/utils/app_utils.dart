import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';

class AppUtils {
  static var mTime;

  bool isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static showSnackBarMessage(String message) {
    if (message.isNotEmpty) {
      // Fluttertoast.showToast(
      //   msg: message,
      // );
      Get.rawSnackbar(message: message);
    }
  }

  static showToastMessage(String message) {
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
        msg: message,
      );
    }
  }

  static showApiResponseMessage(String? message) {
    if (!StringHelper.isEmptyString(message)) {
      Fluttertoast.showToast(
        msg: message ?? "",
      );
      // Get.rawSnackbar(message: message);
    }
  }

  static getStringTr(String key) {
    return key.tr;
  }

  static showErrorMessage() {}

  static Future<String> getDeviceName() async {
    String deviceName = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model.isNotEmpty ? androidInfo.model : "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName =
          iosInfo.utsname.machine.isNotEmpty ? iosInfo.utsname.machine : "";
    }
    return deviceName;
  }

  static Future<String> getDeviceUniqueId() async {
    String deviceId = "";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id ?? "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "";
    }
    return deviceId;
  }

  static Color haxColor(String colorHexCode) {
    String colorNew = '0xff$colorHexCode';
    colorNew = colorNew.replaceAll("#", '');
    int colorInt = int.parse(colorNew);
    return Color(colorInt);
  }

  static Future<bool> interNetCheck() async {
    try {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 3); //3 minutes
      dio.options.receiveTimeout = const Duration(minutes: 3); //3 minutes
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  static BoxShadow boxShadow(Color color, double radius) {
    return BoxShadow(
      blurRadius: radius,
      color: color,
    );
  }

  static BoxDecoration getGrayBorderDecoration(
      {Color? color,
      double? radius,
      double? borderWidth,
      Color? borderColor,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color ?? Colors.transparent,
      boxShadow: boxShadow ?? null,
      border: Border.all(
          width: borderWidth ?? 0.6, color: borderColor ?? Colors.transparent),
      borderRadius: BorderRadius.circular(radius ?? 12),
    );
  }

  static BoxDecoration getDashboardItemDecoration(
      {Color? color,
      double? radius,
      double? borderWidth,
      Color? borderColor,
      double? shadowRadius,
      List<BoxShadow>? boxShadow}) {
    return BoxDecoration(
      color: color ?? backgroundColor,
      boxShadow: boxShadow ??
          [AppUtils.boxShadow(Colors.grey.shade300, shadowRadius ?? 6)],
      border: Border.all(
          width: borderWidth ?? 0.6,
          color: borderColor ?? Colors.grey.shade300),
      borderRadius: BorderRadius.circular(radius ?? 45),
    );
  }

  static void copyText(String? value) {
    if (!StringHelper.isEmptyString(value)) {
      Clipboard.setData(ClipboardData(text: value ?? ""));
      AppUtils.showToastMessage('copied_to_clip_board'.tr);
    }
  }

  static void printLongString(String text) {
    const int chunkSize = 800; // avoid logcat limit
    for (int i = 0; i < text.length; i += chunkSize) {
      final endIndex = (i + chunkSize < text.length) ? i + chunkSize : text.length;
      print(text.substring(i, endIndex));
    }
  }
}
