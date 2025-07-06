import 'dart:ffi';

import 'package:tulsi_hotel/pages/common/model/user_info.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/utils/app_storage.dart';

class UserUtils {
  static int getLoginUserId() {
    UserInfo info = Get.find<AppStorage>().getUserInfo();
    return info.id ?? 0;
  }

  static String getLoginUserName() {
    UserInfo info = Get.find<AppStorage>().getUserInfo();
    return info.name ?? "";
  }

  static bool isAdmin() {
    UserInfo info = Get.find<AppStorage>().getUserInfo();
    // return info.userTypeId == AppConstants.userType.admin;
    return false;
  }

  static bool isEmployee() {
    UserInfo? info = Get.find<AppStorage>().getUserInfo();
    // return info.userTypeId == AppConstants.userType.employee;
    return false;
  }

  static bool isManager() {
    UserInfo? info = Get.find<AppStorage>().getUserInfo();
    // return info.userTypeId == AppConstants.userType.projectManager;
    return false;
  }

  static bool isSupervisor() {
    UserInfo? info = Get.find<AppStorage>().getUserInfo();
    // return info.userTypeId == AppConstants.userType.supervisor;
    return false;
  }

  static String getCommaSeparatedIdsString(List<UserInfo> listCheckedUsers) {
    List<int> listIds = [];
    for (var info in listCheckedUsers) {
      listIds.add(info.id ?? 0);
    }
    return listIds.isNotEmpty ? listIds.join(',') : "";
  }
}
