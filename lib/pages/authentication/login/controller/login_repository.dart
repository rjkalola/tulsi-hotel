import 'package:dio/dio.dart' as multi;
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/network/api_request.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class LoginRepository {
  void login({
    multi.FormData? formData,
    Function(ResponseModel responseModel)? onSuccess,
    Function(ResponseModel error)? onError,
  }) {
    ApiRequest(
            url: ApiConstants.loginUrl,
            apiMethod: ApiConstants.method.post,
            formData: formData,
            isFormData: true)
        .apiRequest(
      onSuccess: (data) {
        onSuccess!(data);
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
