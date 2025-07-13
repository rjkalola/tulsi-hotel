import 'package:tulsi_hotel/pages/product_list/model/product_sub_category_info.dart';

class ProductCategoryInfo {
  int? categoryId;
  String? categoryEnglishName;
  String? categoryGujaratiName;
  int? isSelection;
  int? selectionQty;
  List<ProductSubCategoryInfo>? details;

  ProductCategoryInfo(
      {this.categoryId,
      this.categoryEnglishName,
      this.categoryGujaratiName,
      this.isSelection,
      this.selectionQty,
      this.details});

  ProductCategoryInfo.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryEnglishName = json['category_english_name'];
    categoryGujaratiName = json['category_gujarati_name'];
    isSelection = json['is_selection'];
    selectionQty = json['selection_qty'];
    if (json['details'] != null) {
      details = <ProductSubCategoryInfo>[];
      json['details'].forEach((v) {
        details!.add(new ProductSubCategoryInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_english_name'] = this.categoryEnglishName;
    data['category_gujarati_name'] = this.categoryGujaratiName;
    data['is_selection'] = this.isSelection;
    data['selection_qty'] = this.selectionQty;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
