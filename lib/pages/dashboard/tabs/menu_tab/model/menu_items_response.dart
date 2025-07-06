import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/menu_info.dart';

class MenuItemsResponse {
  bool? isSuccess;
  String? message;
  List<MenuInfo>? data;

  MenuItemsResponse({this.isSuccess, this.message, this.data});

  MenuItemsResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <MenuInfo>[];
      json['Data'].forEach((v) {
        data!.add(new MenuInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
