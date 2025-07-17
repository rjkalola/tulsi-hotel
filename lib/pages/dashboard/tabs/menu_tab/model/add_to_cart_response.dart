class AddToCartResponse {
  bool? isSuccess;
  int? productId;
  String? message;
  int? itemId;
  int? cartId;
  int? totalAmount;
  int? taxAmount;
  int? deliveryCharge;
  int? finalAmount;
  int? cartCount;

  AddToCartResponse(
      {this.isSuccess,
        this.productId,
        this.message,
        this.itemId,
        this.cartId,
        this.totalAmount,
        this.taxAmount,
        this.deliveryCharge,
        this.finalAmount,
        this.cartCount});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    productId = json['product_id'];
    message = json['message'];
    itemId = json['item_id'];
    cartId = json['cart_id'];
    totalAmount = json['totalAmount'];
    taxAmount = json['taxAmount'];
    deliveryCharge = json['deliveryCharge'];
    finalAmount = json['finalAmount'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['product_id'] = this.productId;
    data['message'] = this.message;
    data['item_id'] = this.itemId;
    data['cart_id'] = this.cartId;
    data['totalAmount'] = this.totalAmount;
    data['taxAmount'] = this.taxAmount;
    data['deliveryCharge'] = this.deliveryCharge;
    data['finalAmount'] = this.finalAmount;
    data['cart_count'] = this.cartCount;
    return data;
  }
}
