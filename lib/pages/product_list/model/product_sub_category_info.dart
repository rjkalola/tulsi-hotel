class ProductSubCategoryInfo {
  int? itemId;
  String? gujaratiName;
  String? englishName;
  String? image;
  bool? isCheck;

  ProductSubCategoryInfo(
      {this.itemId,
      this.gujaratiName,
      this.englishName,
      this.image,
      this.isCheck});

  ProductSubCategoryInfo.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    gujaratiName = json['gujarati_name'];
    englishName = json['english_name'];
    image = json['image'];
    isCheck = json['is_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['gujarati_name'] = this.gujaratiName;
    data['english_name'] = this.englishName;
    data['image'] = this.image;
    data['is_check'] = this.isCheck;
    return data;
  }
}
