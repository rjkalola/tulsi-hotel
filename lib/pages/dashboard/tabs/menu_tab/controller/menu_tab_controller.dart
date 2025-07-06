import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/add_to_cart_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/menu_info.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/menu_items_response.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class MenuTabController extends GetxController {
  final _api = MenuTabRepository();
  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = true.obs;
  final menuItemsList = <MenuInfo>[].obs;
  final dashboardController = Get.put(DashboardController());

  @override
  void onInit() {
    super.onInit();
    /*  var arguments = Get.arguments;
    if (arguments != null) {
      userId = arguments[AppConstants.intentKey.id] ?? 0;
    }*/
    getMenuItemsApi(true);
  }

  void getMenuItemsApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    // map["user_id"] = userId;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.getMenuItems(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        MenuItemsResponse response =
            MenuItemsResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          menuItemsList.clear();
          menuItemsList.addAll(response.data ?? []);
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

  void addToCartItemApi(
      {required bool isProgress,
      required int itemId,
      required int quantity}) async {
    Map<String, dynamic> map = {};
    map["item_id"] = itemId;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.addToCartItem(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        AddToCartResponse response =
            AddToCartResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          for (var info in menuItemsList) {
            for (var data in info.items!) {
              if (data.id == (response.itemId ?? 0)) {
                data.quantity = quantity;
                data.cartId = response.cartId ?? 0;
                break;
              }
            }
          }
          menuItemsList.refresh();
          dashboardController.cartCount.value = response.cartCount ?? 0;
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

  void updateCartItemApi(
      {required bool isProgress,
      required int cartId,
      required int itemId,
      required int quantity}) async {
    Map<String, dynamic> map = {};
    map["cart_id"] = cartId;
    map["quantity"] = quantity;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.updateCartItem(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        AddToCartResponse response =
            AddToCartResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          for (var info in menuItemsList) {
            for (var data in info.items!) {
              if (data.id == itemId) {
                data.quantity = quantity;
                data.cartId = response.cartId ?? 0;
                break;
              }
            }
          }
          menuItemsList.refresh();
          dashboardController.cartCount.value = response.cartCount ?? 0;
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
