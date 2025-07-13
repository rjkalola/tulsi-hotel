import 'package:tulsi_hotel/pages/product_list/model/product_info.dart';

class ProductListResponse {
  bool? isSuccess;
  int? cartCount;
  List<ProductInfo>? data;

  ProductListResponse({this.isSuccess, this.cartCount, this.data});

  ProductListResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    cartCount = json['cart_count'];
    if (json['Data'] != null) {
      data = <ProductInfo>[];
      json['Data'].forEach((v) {
        data!.add(new ProductInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['cart_count'] = this.cartCount;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
