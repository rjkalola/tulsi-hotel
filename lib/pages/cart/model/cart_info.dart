class CartInfo {
  int? id;
  int? productId;
  int? itemId;
  String? englishName;
  String? gujaratiName;
  String? image;
  int? price;
  int? quantity;
  int? totalAmount;
  int? amount;
  List<String>? items;

  CartInfo(
      {this.id,
      this.productId,
      this.itemId,
      this.englishName,
      this.gujaratiName,
      this.image,
      this.price,
      this.quantity,
      this.totalAmount,
      this.amount,
      this.items});

  CartInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    itemId = json['item_id'];
    englishName = json['english_name'];
    gujaratiName = json['gujarati_name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    totalAmount = json['total_amount'];
    amount = json['amount'];
    items = (json['items'] as List?)?.whereType<String>().toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['item_id'] = this.itemId;
    data['english_name'] = this.englishName;
    data['gujarati_name'] = this.gujaratiName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_amount'] = this.totalAmount;
    data['amount'] = this.amount;
    data['items'] = this.items;
    return data;
  }
}
