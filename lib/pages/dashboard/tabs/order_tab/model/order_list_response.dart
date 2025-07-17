import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/model/order_info.dart';

class OrderListResponse {
  bool? isSuccess;
  String? message;
  List<OrderInfo>? data;
  int? offset;

  OrderListResponse({this.isSuccess, this.message, this.data, this.offset});

  OrderListResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <OrderInfo>[];
      json['Data'].forEach((v) {
        data!.add(new OrderInfo.fromJson(v));
      });
    }
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    return data;
  }
}
