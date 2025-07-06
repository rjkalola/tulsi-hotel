class AddToCartResponse {
  bool? isSuccess;
  String? message;
  int? data;
  int? cartCount;
  int? itemId;
  int? cartId;

  AddToCartResponse(
      {this.isSuccess,
      this.message,
      this.data,
      this.cartCount,
      this.itemId,
      this.cartId});

  AddToCartResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['message'];
    data = json['Data'];
    cartCount = json['cart_count'];
    itemId = json['item_id'];
    cartId = json['cart_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['message'] = this.message;
    data['Data'] = this.data;
    data['cart_count'] = this.cartCount;
    data['item_id'] = this.itemId;
    data['cart_id'] = this.cartId;
    return data;
  }
}
