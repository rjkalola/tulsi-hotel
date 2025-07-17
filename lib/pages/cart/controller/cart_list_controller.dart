import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_repository.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_info.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_list_response.dart';
import 'package:tulsi_hotel/pages/dashboard/model/dashboard_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/home_tab/controller/home_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_repository.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/add_to_cart_response.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/update_cart_response.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/app_constants.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/utils/user_utils.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/base_response.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

class CartListController extends GetxController {
  final _api = CartListRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs,
      addressVisible = false.obs;
  RxInt totalAmount = 0.obs,
      taxAmount = 0.obs,
      deliveryCharge = 0.obs,
      totalToPay = 0.obs;
  final address = "".obs;
  final commentController = TextEditingController().obs;

  final cartList = <CartInfo>[].obs;
  late Razorpay _razorpay;

  @override
  Future<void> onInit() async {
    super.onInit();
    print("onInit");
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
          cartList.refresh();
          address.value = response.address ?? "";
          addressVisible.value = true;
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

  void placeOrderApi({
    required bool isProgress,
    required String razorPayId,
  }) async {
    Map<String, dynamic> map = {};
    map["razorpay_ref_id"] = razorPayId;
    map["total_amount"] = totalAmount.value;
    map["tax_amount"] = taxAmount.value;
    map["delivery_charges"] = deliveryCharge.value;
    map["final_amount"] = totalToPay.value;
    map["comment"] = StringHelper.getText(commentController.value);

    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    _api.placeOrder(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        BaseResponse response =
            BaseResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          AppUtils.showApiResponseMessage(response.message ?? "");
          var arguments = {AppConstants.intentKey.dashboardTabIndex: 2};
          Get.offAllNamed(AppRoutes.dashboardScreen, arguments: arguments);
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
      required int quantity,
      required int index}) async {
    Map<String, dynamic> map = {};
    map["cart_id"] = cartId;
    map["quantity"] = quantity;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    MenuTabRepository().updateCartItem(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        UpdateCartResponse response =
            UpdateCartResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          totalAmount.value = response.totalAmount ?? 0;
          taxAmount.value = response.taxAmount ?? 0;
          deliveryCharge.value = response.deliveryCharge ?? 0;
          totalToPay.value = response.finalAmount ?? 0;
          // if (quantity == 0) {
          //   cartList.removeAt(index);
          // } else {
          //   for (var info in cartList) {
          //     if (info.id == cartId) {
          //       info.quantity = quantity;
          //       break;
          //     }
          //   }
          // }
          cartList.clear();
          cartList.addAll(response.data ?? []);
          cartList.refresh();
          // getCheckoutApi();
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

  void dashboardResponseApi(bool isProgress) async {
    Map<String, dynamic> map = {};
    map["language"] = 2;
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = isProgress;
    HomeTabRepository().dashboardResponse(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        DashboardResponse response =
            DashboardResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          address.value = response.data?.address ?? "";
          addressVisible.value = true;
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

  moveToAddress() async {
    var result = await Get.toNamed(AppRoutes.addressListScreen);
    dashboardResponseApi(false);
  }

  //Razor Pay Implementation
  void openCheckout() {
    if (totalAmount.value == 0) {
      AppUtils.showToastMessage('please_select_item'.tr);
      return;
    }

    if (StringHelper.isEmptyString(address.value)) {
      AppUtils.showToastMessage('please_add_address'.tr);
      return;
    }

    var options = {
      'key': 'rzp_test_DIGWKn7u2JGaMY', // Replace with your test/live key
      'amount': totalToPay.value * 100, // Amount in paise
      'name': 'app_title'.tr,
      'description': '${'app_title'.tr} ${'order'.tr} Payment',
      'prefill': {
        'contact': UserUtils.getUserInfo().phoneNumber ?? "",
        'email': UserUtils.getUserInfo().email ?? "",
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Razorpay Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Get.snackbar('Success', 'Payment ID: ${response.paymentId}');
    if (!StringHelper.isEmptyString(response.paymentId)) {
      placeOrderApi(isProgress: true, razorPayId: response.paymentId ?? "");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Get.snackbar('Failed', 'Error: ${response.message}');
    // Add your error handling here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Get.snackbar('External Wallet', 'Wallet: ${response.walletName}');
    // Optional wallet handler
  }

  @override
  void onClose() {
    Get.delete<CartListController>();
    _razorpay.clear();
    super.onClose();
  }
}
