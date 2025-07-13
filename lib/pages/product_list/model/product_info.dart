import 'package:tulsi_hotel/pages/product_list/model/product_category_info.dart';

class ProductInfo {
  int? id;
  String? englishName;
  String? gujaratiName;
  String? englishDescription;
  String? gujaratiDescription;
  int? price;
  List<ProductCategoryInfo>? items;

  ProductInfo(
      {this.id,
        this.englishName,
        this.gujaratiName,
        this.englishDescription,
        this.gujaratiDescription,
        this.price,
        this.items});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['english_name'];
    gujaratiName = json['gujarati_name'];
    englishDescription = json['english_description'];
    gujaratiDescription = json['gujarati_description'];
    price = json['price'];
    if (json['items'] != null) {
      items = <ProductCategoryInfo>[];
      json['items'].forEach((v) {
        items!.add(new ProductCategoryInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['english_name'] = this.englishName;
    data['gujarati_name'] = this.gujaratiName;
    data['english_description'] = this.englishDescription;
    data['gujarati_description'] = this.gujaratiDescription;
    data['price'] = this.price;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}