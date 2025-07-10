// views/location_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/pages/address_location/controller/address_location_controller.dart';
import 'package:tulsi_hotel/pages/address_location/view/widgets/address_location_toolbar_widget.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/cardview/card_view_dashboard_item.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/textfield/text_field_border.dart';

class AddressLocationScreen extends StatelessWidget {
  final controller = Get.put(AddressLocationController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            AddressLocationToolbarWidget(),
            Expanded(
              child: Stack(children: [
                Obx(() => GoogleMap(
                      onMapCreated: controller.onMapCreated,
                      onCameraMove: (position) {
                        controller.addressInfo.value.latitude = position.target.latitude;
                        controller.addressInfo.value.longitude =  position.target.longitude;
                        print("onCameraMove lat:"+controller.addressInfo.value.latitude.toString());
                        print("onCameraMove lon:"+controller.addressInfo.value.longitude.toString());
                      },
                      initialCameraPosition: CameraPosition(
                        target: controller.selectedLatLng.value,
                        zoom: 18,
                      ),
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                    )),
                Align(
                  alignment: Alignment.center,
                  child: ImageUtils.setSvgAssetsImage(
                      path: Drawable.centerLocationPin, width: 40, height: 40),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Material(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(45),
                          child: TextFieldBorder(
                            textEditingController: searchController,
                            hintText: 'search_an_area_or_address'.tr,
                            labelText: 'search_an_area_or_address'.tr,
                            keyboardType: TextInputType.name,
                            borderRadius: 45,
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onValueChange: controller.searchPlaces,
                            validator: MultiValidator([]),
                          ),
                        ),
                        SizedBox(height: 14),
                        Obx(() {
                          final results = controller.searchResults;
                          if (results.isEmpty) return SizedBox.shrink();
                          return Material(
                            elevation: 4,
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: results.length,
                              itemBuilder: (context, index) {
                                final place = results[index];
                                return ListTile(
                                  title: Text(place['description']),
                                  onTap: () {
                                    controller.selectPlace(place['place_id']);
                                    // searchController.text = place['description'];
                                    searchController.text = "";
                                    FocusScope.of(context).unfocus();
                                  },
                                );
                              },
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.orange.withOpacity(0.6),
                          width: 0.6,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2, right: 12),
                              child: ImageUtils.setSvgAssetsImage(
                                  path: Drawable.address,
                                  width: 18,
                                  height: 18),
                            ),
                            Expanded(
                                child: PrimaryTextViewInter(
                              fontSize: 15,
                                  getAddressText(controller.addressInfo.value),
                            ))
                          ],
                        ),
                        SizedBox(height: 12),
                        PrimaryButton(
                            padding: EdgeInsets.fromLTRB(16, 2, 16, 8),
                            buttonText: 'confirm_and_save'.tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            onPressed: () {
                              controller.storeAddressApi(controller.addressInfo.value);
                            })
                      ],
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      )),
    );
  }

  String getAddressText(AddressInfo info) {
    String address = "";
    address = info.flatNumber ?? "";
    address += !StringHelper.isEmptyString(info.apartment)
        ? ", ${info.apartment}"
        : "";
    address += !StringHelper.isEmptyString(info.area) ? ", ${info.area}" : "";
    address += info.pincode != 0 ? " - ${info.pincode}" : "";
    return address;
  }
}
