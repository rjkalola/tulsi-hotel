import 'dart:io';

class AppConstants {
  static const DialogIdentifier dialogIdentifier = DialogIdentifier();
  static const SharedPreferenceKey sharedPreferenceKey = SharedPreferenceKey();
  static const IntentKey intentKey = IntentKey();
  static const Action action = Action();
  static const AttachmentType attachmentType = AttachmentType();
  static const Type type = Type();

  static String deviceType = Platform.isAndroid ? "1" : "2";

  // static const String defaultFlagUrl =
  //     "https://devcdn.otmsystem.com/flags/png/gb_32.png";
  static const String defaultFlagUrl = "assets/country_flag/gb.svg";
  static const String permissionIconsAssetsPath =
      "assets/user_permission_icons/";
}

class IntentKey {
  const IntentKey(); // <
  final String id = 'ID';
  final String phoneNumber = 'PHONE_NUMBER';
  final String addressInfo = 'ADDRESS_INFO';
  final String productType = 'PRODUCT_TYPE';
  final String dayType = 'DAY_TYPE';
  final String dashboardTabIndex = 'DASHBOARD_TAB_INDEX';
}

class DialogIdentifier {
  const DialogIdentifier(); // <---
  final String logout = 'logout';
  final String delete = 'DELETE';
  final String attachmentOptionsList = 'ATTACHMENT_OPTIONS_LIST';
  final String removeAccount = 'REMOVE_ACCOUNT';
}

class SharedPreferenceKey {
  const SharedPreferenceKey(); // <---
  final String userInfo = "USER_INFO";
  final String accessToken = "ACCESS_TOKEN";
}

class Action {
  const Action(); //
  final String items = "ITEMS";
  final String selectImageFromCamera = 'SELECT_IMAGE_FROM_CAMERA';
  final String selectImageFromGallery = 'SELECT_IMAGE_FROM_GALLERY';
}

class AttachmentType {
  const AttachmentType(); //
  final String image = "image";
  final String camera = "camera";
  final String croppedImage = "croppedImage";
}

class Type {
  const Type(); //
}
