class BaseResponse {
  String? message, statusCode;
  int? errorCode;
  bool? isSuccess;

  BaseResponse({this.isSuccess, this.message, this.statusCode, this.errorCode});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorCode = json['ErrorCode'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    data['Message'] = message;
    data['statusCode'] = statusCode;
    data['ErrorCode'] = errorCode;
    return data;
  }
}
