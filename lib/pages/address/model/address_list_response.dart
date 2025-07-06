import 'package:tulsi_hotel/pages/address/model/adress_info.dart';

class AddressListResponse {
  bool? isSuccess;
  List<AddressInfo>? data;

  AddressListResponse({this.isSuccess, this.data});

  AddressListResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['Data'] != null) {
      data = <AddressInfo>[];
      json['Data'].forEach((v) {
        data!.add(new AddressInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
