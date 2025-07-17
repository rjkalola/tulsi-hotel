class OrderInfo {
  int? id;
  int? orderNumber;
  String? name;
  int? phoneNumber;
  String? comment;
  String? address;
  int? productId;
  int? itemId;
  String? englishName;
  String? gujaratiName;
  int? quantity;
  int? totalAmount;
  List<String>? items;
  String? orderText;

  OrderInfo(
      {this.id,
      this.orderNumber,
      this.name,
      this.phoneNumber,
      this.comment,
      this.address,
      this.productId,
      this.itemId,
      this.englishName,
      this.gujaratiName,
      this.quantity,
      this.totalAmount,
      this.items,
      this.orderText});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    comment = json['comment'];
    address = json['address'];
    productId = json['product_id'];
    itemId = json['item_id'];
    englishName = json['english_name'];
    gujaratiName = json['gujarati_name'];
    quantity = json['quantity'];
    totalAmount = json['total_amount'];
    items = (json['items'] as List?)?.whereType<String>().toList() ?? [];
    orderText = json['order_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['comment'] = this.comment;
    data['address'] = this.address;
    data['product_id'] = this.productId;
    data['item_id'] = this.itemId;
    data['english_name'] = this.englishName;
    data['gujarati_name'] = this.gujaratiName;
    data['quantity'] = this.quantity;
    data['total_amount'] = this.totalAmount;
    data['items'] = this.items;
    data['order_text'] = this.orderText;
    return data;
  }
}
