import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_repository.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_info.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_list_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/add_to_cart_response.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class CartListController extends GetxController {
  final _api = CartListRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs;
  RxInt totalAmount = 0.obs,
      taxAmount = 0.obs,
      deliveryCharge = 0.obs,
      totalToPay = 0.obs;
  final commentController = TextEditingController().obs;

  final cartList = <CartInfo>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getCheckoutApi();
  }

  void getCheckoutApi() async {
    Map<String, dynamic> map = {};
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.checkout(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        CartListResponse response =
            CartListResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          cartList.clear();
          cartList.addAll(response.data ?? []);
          totalAmount.value = response.totalAmount ?? 0;
          taxAmount.value = response.taxAmount ?? 0;
          deliveryCharge.value = response.deliveryCharge ?? 0;
          totalToPay.value = response.finalAmount ?? 0;
          isMainViewVisible.value = true;
        } else {
          // AppUtils.showSnackBarMessage(responseModel.statusMessage!);
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showSnackBarMessage('no_internet'.tr);
        }
      },
    );
  }

  void updateCartItemApi(
      {required bool isProgress,
      required int cartId,
      required int quantity}) async {
    Map<String, dynamic> map = {};
    map["cart_id"] = cartId;
    map["quantity"] = quantity;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    MenuTabRepository().updateCartItem(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        AddToCartResponse response =
            AddToCartResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          for (var info in cartList) {
            if (info.id == cartId) {
              info.quantity = quantity;
              break;
            }
          }
          cartList.refresh();
        } else {
          AppUtils.showApiResponseMessage(response.message ?? "");
        }
        isLoading.value = false;
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showApiResponseMessage('no_internet'.tr);
        }
      },
    );
  }
}
