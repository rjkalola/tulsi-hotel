// controllers/location_controller.dart
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_repository.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/google_place_service.dart';
import 'package:tulsi_hotel/utils/location_service_new.dart';
import 'package:dio/dio.dart' as multi;
import 'package:tulsi_hotel/web_services/api_constants.dart';
import 'package:tulsi_hotel/web_services/response/base_response.dart';
import 'package:tulsi_hotel/web_services/response/response_model.dart';

import '../../../utils/app_constants.dart';

class AddressLocationController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();
  final placesService =
      GooglePlacesService("AIzaSyA73MTz-pQbYcD_N364dHttbRd4cnppVN8");

  var searchResults = <Map<String, dynamic>>[].obs;
  var selectedLatLng = LatLng(23.0225, 72.5714).obs;
  final locationService = LocationServiceNew();
  String latitude = "", longitude = "", location = "";

  RxBool isLoading = false.obs,
      isInternetNotAvailable = false.obs,
      isMainViewVisible = false.obs,
      isLocationLoaded = true.obs;
  final addressInfo = AddressInfo().obs;

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    var arguments = Get.arguments;
    if (arguments != null) {
      addressInfo.value = arguments[AppConstants.intentKey.addressInfo] ?? "";
      if ((addressInfo.value.id ?? 0) > 0) {
        if (addressInfo.value.latitude != null &&
            addressInfo.value.longitude != null) {
          selectedLatLng.value =
              LatLng(addressInfo.value.latitude!, addressInfo.value.longitude!);

          Future.delayed(Duration(milliseconds: 300), () async {
            if (mapController.isCompleted) {
              final controller = await mapController.future;
              controller
                  .animateCamera(CameraUpdate.newLatLng(selectedLatLng.value));
            }
          });

        }
      }
    }
    locationRequest();
    appLifeCycle();
  }

  void storeAddressApi(AddressInfo info) async {
    Map<String, dynamic> map = {};
    map["id"] = info.id ?? 0;
    map["flat_number"] = info.flatNumber ?? "";
    map["apartment"] = info.apartment ?? "";
    map["area"] = info.area ?? "";
    map["pincode"] = info.pincode ?? "";
    map["latitude"] = info.latitude ?? "";
    map["longitude"] = info.longitude ?? "";

    multi.FormData formData = multi.FormData.fromMap(map);
    isLoading.value = true;
    AddressListRepository().storeAddress(
      formData: formData,
      onSuccess: (ResponseModel responseModel) {
        BaseResponse response =
            BaseResponse.fromJson(jsonDecode(responseModel.result!));
        if (response.isSuccess ?? false) {
          Get.back(result: true);
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

  Future<void> searchPlaces(String input) async {
    if (input.isEmpty) return;
    searchResults.value = await placesService.getAutocomplete(input);
  }

  Future<void> selectPlace(String placeId) async {
    final loc = await placesService.getLatLngFromPlaceId(placeId);
    final latLng = LatLng(loc['lat']!, loc['lng']!);
    addressInfo.value.latitude = latLng.latitude;
    addressInfo.value.longitude = latLng.longitude;
    selectedLatLng.value = latLng;
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(latLng));
    searchResults.clear();
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
      print("loaded location");
      isLocationLoaded.value = true;
      if ((addressInfo.value.id ?? 0) == 0) {
        latitude = latLon.latitude.toString();
        longitude = latLon.longitude.toString();
        location = await LocationServiceNew.getAddressFromCoordinates(
            latLon.latitude, latLon.longitude);
        selectedLatLng.value = LatLng(latLon.latitude, latLon.longitude);
        final controller = await mapController.future;
        controller.animateCamera(CameraUpdate.newLatLng(selectedLatLng.value));
      }
    }
  }
}
