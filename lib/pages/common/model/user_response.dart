import 'package:tulsi_hotel/pages/common/model/user_info.dart';

class UserResponse {
  bool? isSuccess;
  String? message;
  UserInfo? data;

  UserResponse({this.isSuccess, this.data,this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    data = json['Data'] != null ? new UserInfo.fromJson(json['Data']) : null;
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Message'] = this.message;
    return data;
  }
}

