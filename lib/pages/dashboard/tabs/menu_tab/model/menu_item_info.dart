class MenuItemInfo {
  int? id;
  int? categoryId;
  String? gujaratiName;
  String? englishName;
  int? price;
  int? cartId;
  int? quantity;

  MenuItemInfo(
      {this.id,
        this.categoryId,
        this.gujaratiName,
        this.englishName,
        this.price,
        this.cartId,
        this.quantity});

  MenuItemInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    gujaratiName = json['gujarati_name'];
    englishName = json['english_name'];
    price = json['price'];
    cartId = json['cart_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['gujarati_name'] = this.gujaratiName;
    data['english_name'] = this.englishName;
    data['price'] = this.price;
    data['cart_id'] = this.cartId;
    data['quantity'] = this.quantity;
    return data;
  }
}