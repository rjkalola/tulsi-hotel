import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tulsi_hotel/pages/common/model/user_info.dart';
import 'package:tulsi_hotel/utils/app_constants.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';

class AppStorage extends GetxController {
  final storage = GetStorage();
  static String uniqueId = "";

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void setUserInfo(UserInfo info) {
    storage.write(AppConstants.sharedPreferenceKey.userInfo, info.toJson());
  }

  UserInfo getUserInfo() {
    final map = storage.read(AppConstants.sharedPreferenceKey.userInfo) ?? {};
    return UserInfo.fromJson(map);
  }

  void setAccessToken(String token) {
    storage.write(AppConstants.sharedPreferenceKey.accessToken, token);
  }

  String getAccessToken() {
    final token =
        storage.read(AppConstants.sharedPreferenceKey.accessToken) ?? "";
    return token;
  }

  void clearAllData() {
    ApiConstants.accessToken = "";
    removeData(AppConstants.sharedPreferenceKey.userInfo);
    removeData(AppConstants.sharedPreferenceKey.accessToken);
  }

  void removeData(String key) {
    storage.remove(key);
  }
}
