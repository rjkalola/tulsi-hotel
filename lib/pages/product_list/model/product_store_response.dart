class ProductStoreResponse {
  bool? isSuccess;
  int? data;

  ProductStoreResponse({this.isSuccess, this.data});

  ProductStoreResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Data'] = this.data;
    return data;
  }
}
