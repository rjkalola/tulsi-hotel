import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/controller/order_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/model/order_info.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/model/order_list_response.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class OrderTabController extends GetxController {
  final _api = OrderTabRepository();
  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = true.obs,
      isLoadMore = false.obs;
  final orderList = <OrderInfo>[].obs;
  List<OrderInfo> tempList = [];
  final dashboardController = Get.put(DashboardController());
  var offset = 0;
  var mIsLastPage = false;
  late ScrollController controller;

  @override
  void onInit() {
    super.onInit();
    controller = ScrollController();
    controller.addListener(_scrollListener);
    getOrdersApi(true, false);
  }

  void getOrdersApi(bool isProgress, bool clearOffset) async {
    if (clearOffset) {
      offset = 0;
      mIsLastPage = false;
    }
    isLoadMore.value = offset > 0;
    if (isProgress) isLoading.value = true;
    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["offset"] = offset;
    multi.FormData formData = multi.FormData.fromMap(map);
    _api.getOrders(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        isLoading.value = false;
        isLoadMore.value = false;
        OrderListResponse response =
            OrderListResponse.fromJson(jsonDecode(responseModel.result!));

        if (offset == 0) {
          tempList.clear();
          tempList.addAll(response.data!);
          orderList.value = tempList;
          orderList.refresh();
        } else if (response.data != null && response.data!.isNotEmpty) {
          tempList.addAll(response.data!);
          orderList.value = tempList;
          orderList.refresh();
        }

        offset = response.offset!;
        if (offset == 0) {
          mIsLastPage = true;
        } else {
          mIsLastPage = false;
        }
      },
      onError: (ResponseModel error) {
        isLoading.value = false;
        isLoading.value = false;
        if (error.statusCode == ApiConstants.CODE_NO_INTERNET_CONNECTION) {
          AppUtils.showApiResponseMessage('no_internet'.tr);
        }
      },
    );
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange &&
        !mIsLastPage) {
      getOrdersApi(false, false);
    }
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {}
  }
}
