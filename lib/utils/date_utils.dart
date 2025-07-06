import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tulsi_hotel/pages/common/listener/select_time_listener.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

import '../pages/common/listener/select_date_listener.dart';

class DateUtil {
  static String changeDateFormat(String date, String format, String newFormat) {
    DateFormat inputDateFormat = DateFormat(format);
    DateTime inputDate = inputDateFormat.parse(date);
    DateFormat outputDateFormat = DateFormat(newFormat);
    return outputDateFormat.format(inputDate);
  }

  static DateTime? stringToDate(String date, String format) {
    if (StringHelper.isEmptyString(date) || StringHelper.isEmptyString(format))
      return null;

    DateTime? d = null;
    DateFormat mFormatter = DateFormat(format);
    try {
      d = mFormatter.parse(date);
    } catch (e) {
      d = null;
    }
    return d;
  }

  static String dateToString(DateTime? date, String format) {
    String result = "";
    if (date == null || StringHelper.isEmptyString(format)) return result;
    DateFormat mFormatter = DateFormat(format);
    try {
      result = mFormatter.format(date);
    } catch (e) {
      result = "";
    }
    return result;
  }

  static String timeToString(DateTime? time, String format) {
    String result = "";
    if (time == null || StringHelper.isEmptyString(format)) return result;
    // final now = DateTime.now();
    // final date = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    DateFormat mFormatter = DateFormat(format);
    try {
      result = mFormatter.format(time);
    } catch (e) {
      result = "";
    }
    return result;
  }

  static String seconds_To_MM_SS(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  static String getCurrentTimeInFormat(String format) {
    final now = DateTime.now();
    final formatter = DateFormat(format);
    return formatter.format(now);
  }

  static int dateDifferenceInSeconds(DateTime? date1, DateTime? date2) {
    Duration diff = date2!.difference(date1!);
    int totalSeconds = diff.inSeconds;
    return totalSeconds;
  }

  static TimeOfDay? getTimeOfDayFromHHMM(String? timeString) {
    if (timeString != null) {
      final parts = timeString.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return null;
    }
  }

  static DateTime? getDateTimeFromHHMM(String? timeString) {
    if (timeString != null) {
      final now = DateTime.now();
      final format = DateFormat(HH_MM_24); // 24-hour format
      final time = format.parse(timeString);
      return DateTime(now.year, now.month, now.day, time.hour, time.minute);
    } else {
      return null;
    }
  }

  static Future<void> showDatePickerDialog(
      {DateTime? initialDate,
      required DateTime firstDate,
      required DateTime lastDate,
      required String dialogIdentifier,
      required SelectDateListener selectDateListener}) async {
    if (Platform.isIOS) {
      DateTime initial = DateTime.now().subtract(Duration(minutes: 1));
      DateTime? selectedDate = initialDate;
      DateTime safeInitial = clampInitialDate(
        initial: initialDate ?? initial,
        minimum: firstDate,
        maximum: lastDate,
      );
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              // Toolbar
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleTextView(
                        "Cancel",
                        color: secondaryTextColor,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleTextView(
                        "Done",
                        color: defaultAccentColor,
                      ),
                      onPressed: () {
                        selectDateListener.onSelectDate(
                            selectedDate ?? DateTime.now(), dialogIdentifier);
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              // Date Picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: safeInitial,
                  maximumDate: truncateToSeconds(lastDate),
                  minimumDate: truncateToSeconds(firstDate),
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
      );
      if (picked != null) {
        selectDateListener.onSelectDate(picked, dialogIdentifier);
      }
    }
  }

  static Future<void> showTimePickerDialog(
      {DateTime? initialTime,
      required String dialogIdentifier,
      required SelectTimeListener selectTimeListener}) async {
    if (Platform.isIOS) {
      DateTime selectedTime = initialTime ?? DateTime.now();
      showCupertinoModalPopup(
        context: Get.context!,
        builder: (_) => Container(
          height: 300,
          color: dashBoardBgColor,
          child: Column(
            children: [
              // Toolbar
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleTextView(
                        "Cancel",
                        color: secondaryTextColor,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TitleTextView(
                        "Done",
                        color: defaultAccentColor,
                      ),
                      onPressed: () {
                        selectTimeListener.onSelectTime(
                            selectedTime, dialogIdentifier);
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
              Divider(height: 1),
              // Picker takes remaining space
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: initialTime ?? DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newTime) {
                    selectedTime = newTime;
                    // Save or use time
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else if (Platform.isAndroid) {
      TimeOfDay initiallyTimeOfDay = initialTime != null
          ? convertDateTimeToTimeOfDay(initialTime)
          : TimeOfDay.now();
      final pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: initiallyTimeOfDay,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        selectTimeListener.onSelectTime(
            convertTimeOfDayToDateTime(pickedTime), dialogIdentifier);
      }
    }
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay tod,
      {DateTime? baseDate}) {
    final now = baseDate ?? DateTime.now();
    return DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  }

  static TimeOfDay convertDateTimeToTimeOfDay(DateTime dt) {
    return TimeOfDay(hour: dt.hour, minute: dt.minute);
  }

  static DateTime truncateToSeconds(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);

  static DateTime clampInitialDate({
    required DateTime initial,
    required DateTime minimum,
    required DateTime maximum,
  }) {
    final min = truncateToSeconds(minimum);
    final max = truncateToSeconds(maximum);
    DateTime init = truncateToSeconds(initial);

    if (init.isBefore(min)) return min;
    if (init.isAfter(max)) return max;
    return init;
  }

  static DateTime clampAndTruncateDateTime({
    required DateTime initial,
    required DateTime min,
    required DateTime max,
  }) {
    // Truncate to seconds (remove microseconds)
    DateTime truncate(DateTime dt) =>
        DateTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);

    DateTime i = truncate(initial);
    DateTime minT = truncate(min);
    DateTime maxT = truncate(max);

    if (i.isBefore(minT)) return minT;
    if (i.isAfter(maxT)) return maxT;
    return i;
  }

  static String DD_MM_YYYY_DASH = "dd-MM-yyyy";

  static String DD_MM_YYYY_TIME_12_DASH = "dd-MM-yyyy hh:mm a";

  static String DD_MM_YYYY_TIME_24_DASH = "dd-MM-yyyy HH:mm";

  static String DD_MM_YYYY_SLASH = "dd/MM/yyyy";

  static String MM_DD_SLASH = "MM/dd";

  static String DD_MM_YYYY_TIME_12_SLASH = "dd/MM/yyyy hh:mm a";

  static String DD_MM_YYYY_TIME_24_SLASH = "dd/MM/yyyy HH:mm";

  static String DD_MM_YYYY_TIME_24_SLASH2 = "dd/MM/yyyy HH:mm:ss";

  static String MM_DD_YYYY_DASH = "MM-dd-yyyy";

  static String MM_DD_YYYY_TIME_12_DASH = "MM-dd-yyyy hh:mm a";

  static String MM_DD_YYYY_TIME_24_DASH = "MM-dd-yyyy HH:mm";

  static String MM_DD_YYYY_SLASH = "MM/dd/yyyy";

  static String MM_DD_YYYY_TIME_12_SLASH = "MM/dd/yyyy hh:mm a";

  static String MM_DD_YYYY_TIME_24_SLASH = "MM/dd/yyyy HH:mm";

  static String YYYY_MM_DD_DASH = "yyyy-MM-dd";

  static String YYYY_MM_DD_TIME_12_DASH = "yyyy-MM-dd hh:mm a";

//    static String YYYY_MM_DD_TIME_12_DASH2 = "yyyy-MM-dd KK:mm";

  static String YYYY_MM_DD_TIME_24_DASH = "yyyy-MM-dd HH:mm";

  static String YYYY_MM_DD_TIME_24_DASH2 = "yyyy-MM-dd HH:mm:ss";

  static String YYYY_MM_DD_TIME_24_WITHOUT_QUOTE = "yyyyMMddHHmmss";

  static String YYYY_MM_DD_SLASH = "yyyy/MM/dd";

  static String YYYY_MM_DD_TIME_12_SLASH = "yyyy/MM/dd hh:mm a";

  static String YYYY_MM_DD_TIME_24_SLASH = "yyyy/MM/dd HH:mm";

  static String TIME_12_SLASH = "hh:mm a";

  static String DD_MMMM_YYYY_SPACE = "dd MMMM yyyy";

  static String DD_MMMM_YYYY_TIME_12_SPACE = "dd MMMM yyyy hh:mm a";

  static String DD_MMMM_YYYY_TIME_24_SPACE = "dd MMMM yyyy HH:mm";

  static String DD_MMMM_YYYY_DASH = "dd-MMMM-yyyy";

  static String DD_MMMM_YYYY_TIME_12_DASH = "dd-MMMM-yyyy hh:mm a";

  static String DD_MMMM_YYYY_TIME_24_DASH = "dd-MMMM-yyyy HH:mm";

  static String DD_MMMM_YYYY_SLASH = "dd/MMMM/yyyy";

  static String DD_MMMM_YYYY_TIME_12_SLASH = "dd/MMMM/yyyy hh:mm a";

  static String DD_MMMM_YYYY_TIME_24_SLASH = "dd/MMMM/yyyy HH:mm";

  static String DD_MMM_YYYY_SPACE = "dd MMM yyyy";

  static String DD_MMM_YYYY_TIME_12_SPACE = "dd MMM yyyy hh:mm a";

  static String DD_MMM_YYYY_TIME_24_SPACE = "dd MMM yyyy HH:mm";

  static String DD_MMM_YYYY_DASH = "dd-MMM-yyyy";

  static String DD_MMM_YYYY_TIME_12_DASH = "dd-MMM-yyyy hh:mm a";

  static String DD_MMM_YYYY_TIME_24_DASH = "dd-MMM-yyyy HH:mm";

  static String DD_MMM_YYYY_SLASH = "dd/MMM/yyyy";

  static String DD_MMM_YYYY_TIME_12_SLASH = "dd/MMM/yyyy hh:mm a";

  static String DD_MMM_YYYY_TIME_24_SLASH = "dd/MMM/yyyy HH:mm";

  static String DD_MMM_SPACE = "dd MMM";

  static String DD_MMMM_SPACE = "dd MMMM";

  static String MM_YYYY_SLASH = "MM/yyyy";

  static String DD_MMM_TIME_12_SPACE = "dd MMM hh:mm a";

  static String DD_MMM_TIME_24_SPACE = "dd MMM HH:mm";

  static String DD_MM_YYYY_DOT = "dd.MM.yyyy";

  static String DD_MM_YYYY_TIME_12_DOT = "dd.MM.yyyy hh:mm a";

  static String DD_MM_YYYY_TIME_24_DOT = "dd.MM.yyyy HH:mm";

  static String YY_MM_DD_DOT = "yyyy.MM.dd";

  static String YYYY_MM_DD_TIME_12_DOT = "yyyy.MM.dd hh:mm a";

  static String YYYY_MM_DD_TIME_24_DOT = "yyyy.MM.dd HH:mm";

  static String HH_MM_12 = "hh:mm a";

  static String HH_MM = "hh:mm";

  static String HH_MM_24 = "HH:mm";

  static String HH_MM_SS_24_2 = "HH:mm:ss";

  static String HH_MM_SS_24 = "hh:mm:ss";

  static String DD_MMM_EEE_SPACE = "dd MMM (EEE)";

  static String DD_MMM_YYYY_EEE_SPACE = "dd MMM yyyy (EEE)";

  static String DD_MMM_EEE_COMMA_SPACE_HH_MM_24 = "dd MMM, HH:mm";

  static String DD_MMMM_YYYY_TIME_24 = "dd MMMM yyyy HH:mm:ss";
}
