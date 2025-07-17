import 'package:tulsi_hotel/pages/cart/model/cart_info.dart';

class UpdateCartResponse {
  bool? isSuccess;
  String? message;
  List<CartInfo>? data;
  int? totalAmount;
  int? taxAmount;
  int? deliveryCharge;
  int? finalAmount;
  int? cartCount;

  UpdateCartResponse(
      {this.isSuccess,
      this.data,
      this.totalAmount,
      this.taxAmount,
      this.deliveryCharge,
      this.finalAmount,
      this.cartCount,
      this.message});

  UpdateCartResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <CartInfo>[];
      json['Data'].forEach((v) {
        data!.add(new CartInfo.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    taxAmount = json['taxAmount'];
    deliveryCharge = json['deliveryCharge'];
    finalAmount = json['finalAmount'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = this.totalAmount;
    data['taxAmount'] = this.taxAmount;
    data['deliveryCharge'] = this.deliveryCharge;
    data['finalAmount'] = this.finalAmount;
    data['cart_count'] = this.cartCount;
    return data;
  }
}
