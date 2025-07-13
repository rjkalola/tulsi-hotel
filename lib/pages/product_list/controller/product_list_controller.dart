import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/product_list/controller/product_list_repository.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_info.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_list_response.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_store_response.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

import '../../../utils/app_constants.dart';

class ProductListController extends GetxController {
  final _api = ProductListRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs;
  RxInt cartCount = 0.obs;

  final productList = <ProductInfo>[].obs;
  List<ProductInfo> todayList = <ProductInfo>[];
  List<ProductInfo> tomorrowList = <ProductInfo>[];

  final currentIndex = 0.obs;
  late final PageController pageController;
  int productType = 0;

  void changeTab(int index) {
    currentIndex.value = index;
    if (currentIndex.value == 0) {
      if (todayList.isEmpty) {
        getProductsApi();
      } else {
        productList.clear();
        productList.addAll(todayList);
      }
    }

    if (currentIndex.value == 1) {
      if (tomorrowList.isEmpty) {
        getProductsApi();
      } else {
        productList.clear();
        productList.addAll(tomorrowList);
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      productType = arguments[AppConstants.intentKey.productType] ?? 0;
    }
    getProductsApi();
  }

  void getProductsApi() async {
    Map<String, dynamic> map = {};
    map["product_type"] = productType;
    map["day"] = currentIndex.value == 0 ? 1 : 2;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.getProducts(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        ProductListResponse response =
            ProductListResponse.fromJson(jsonDecode(responseModel.result!));
        cartCount.value = response.cartCount ?? 0;
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          if (currentIndex.value == 0) {
            todayList.clear();
            todayList.addAll(response.data ?? []);
            productList.clear();
            productList.addAll(response.data ?? []);
          } else if (currentIndex.value == 1) {
            tomorrowList.clear();
            tomorrowList.addAll(response.data ?? []);
            productList.clear();
            productList.addAll(response.data ?? []);
          }
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

  void storeProductApi(ProductInfo info, int productPosition) async {
    // Map<String, dynamic> map = {};
    // map["product_type"] = productType;
    // map["day"] = currentIndex.value == 0 ? 1 : 2;
    // multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.storeProduct(
      data: jsonEncode(info),
      onSuccess: (ResponseModel responseModel) {
        ProductStoreResponse response =
            ProductStoreResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
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

  void resetCheckedItems(int position) {
    for (var product in productList) {
      for (var category in product.items!) {
        for (var subCategory in category.details!) {
          subCategory.isCheck = false;
        }
      }
    }
    productList.refresh();
  }

  Future<void> moveToCart() async {
    var result = await Get.toNamed(AppRoutes.cartListScreen);
    if (result != null && result) {

    }
  }
}
