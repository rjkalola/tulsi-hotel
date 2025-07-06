import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/address/controller/address_list_controller.dart';
import 'package:tulsi_hotel/pages/address/model/adress_info.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/utils/string_helper.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class AddressList extends StatelessWidget {
  AddressList({super.key});

  final controller = Get.put(AddressListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, position) {
                AddressInfo info = controller.addressList[position];
                return ItemContainer(
                    width: double.infinity,
                    margin:
                        EdgeInsets.only(top: 6, bottom: 6, left: 16, right: 16),
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                    child: Column(
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
                              getAddressText(info),
                            ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, top: 6),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.showSelectShiftDialog(info);
                                },
                                child: PrimaryTextViewInter(
                                  'edit'.tr,
                                  color: defaultAccentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  controller
                                      .showDeleteAddressDialog(info.id ?? 0);
                                },
                                child: PrimaryTextViewInter(
                                  'delete'.tr,
                                  color: defaultAccentColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              },
              itemCount: controller.addressList.length,
              // separatorBuilder: (context, position) => const Padding(
              //   padding: EdgeInsets.only(left: 100),
              //   child: Divider(
              //     height: 0,
              //     color: dividerColor,
              //     thickness: 0.8,
              //   ),
              // ),
              separatorBuilder: (context, position) => Container()),
        ));
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
