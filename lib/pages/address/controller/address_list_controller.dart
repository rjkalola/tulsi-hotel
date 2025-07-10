import 'dart:convert';

import 'package:dio/dio.dart' as multi;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_repository.dart';
import 'package:tulsi_hotel/pages/address/model/address_list_response.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/add_address_dialog.dart';
import 'package:tulsi_hotel/pages/address/view/widgets/add_address_listener.dart';
import 'package:tulsi_hotel/pages/common/listener/DialogButtonClickListener.dart';
import 'package:tulsi_hotel/routes/app_routes.dart';
import 'package:tulsi_hotel/utils/AlertDialogHelper.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/location_service_new.dart';
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/base_response.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

import '../../../utils/app_constants.dart';

class AddressListController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements AddAddressListener, DialogButtonClickListener {
  final _api = AddressListRepository();

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs,
      isLocationLoaded = true.obs;
  final addressList = <AddressInfo>[].obs;
  final locationService = LocationServiceNew();
  String latitude = "", longitude = "", location = "";
  int selectedAddressId = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    locationRequest();
    appLifeCycle();
    addressListResponseApi();
  }

  void addressListResponseApi() async {
    Map<String, dynamic> map = {};
    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.addressListResponse(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        AddressListResponse response =
            AddressListResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          isMainViewVisible.value = true;
          addressList.clear();
          addressList.addAll(response.data ?? []);
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

  void storeAddressApi(AddressInfo info) async {
    Map<String, dynamic> map = {};
    map["id"] = info.id ?? 0;
    map["flat_number"] = info.flatNumber ?? "";
    map["apartment"] = info.apartment ?? "";
    map["area"] = info.area ?? "";
    map["pincode"] = info.pincode ?? "";
    map["latitude"] = latitude ?? "";
    map["longitude"] = longitude ?? "";

    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    _api.storeAddress(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        BaseResponse response =
            BaseResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          addressListResponseApi();
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

  void showSelectShiftDialog(AddressInfo info) {
    Get.bottomSheet(
        AddAddressDialog(
          info: info,
          listener: this,
        ),
        backgroundColor: Colors.transparent,
        isScrollControlled: true);
  }

  showDeleteAddressDialog(int id) async {
    selectedAddressId = id;
    AlertDialogHelper.showAlertDialog(
        "",
        'are_you_sure_you_want_to_delete'.tr,
        'yes'.tr,
        'no'.tr,
        "",
        true,
        this,
        AppConstants.dialogIdentifier.delete);
  }

  @override
  Future<void> onAddAddress(AddressInfo info) async {
    print(info.flatNumber ?? "");
    print(info.apartment ?? "");
    print(info.area ?? "");
    print(info.pincode ?? "");
    // storeAddressApi(info);
    Get.back();

    var arguments = {
      AppConstants.intentKey.addressInfo: info,
    };
    var result = await Get.toNamed(AppRoutes.addressLocationScreen,
        arguments: arguments);
    if (result != null && result) {
      addressListResponseApi();
    }
  }

  void appLifeCycle() {
    AppLifecycleListener(
      onResume: () async {
        if (!isLocationLoaded.value) locationRequest();
      },
    );
  }

  Future<void> locationRequest() async {
    bool isLocationLoaded = await locationService.checkLocationService();
    print("locationLoaded:" + isLocationLoaded.toString());
    if (isLocationLoaded) {
      fetchLocationAndAddress();
    }
  }

  Future<void> fetchLocationAndAddress() async {
    Position? latLon = await LocationServiceNew.getCurrentLocation();
    if (latLon != null) {
      isLocationLoaded.value = true;
      latitude = latLon.latitude.toString();
      longitude = latLon.longitude.toString();
      location = await LocationServiceNew.getAddressFromCoordinates(
          latLon.latitude, latLon.longitude);
    }
  }

  @override
  void onNegativeButtonClicked(String dialogIdentifier) {
    Get.back();
  }

  @override
  void onOtherButtonClicked(String dialogIdentifier) {}

  @override
  void onPositiveButtonClicked(String dialogIdentifier) {
    Get.back();
  }
}
