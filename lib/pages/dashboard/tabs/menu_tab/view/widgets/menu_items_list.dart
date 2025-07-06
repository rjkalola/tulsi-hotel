import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/menu_item_info.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/text/SubTitleTextView.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class MenuItemsList extends StatelessWidget {
  MenuItemsList({super.key, required this.parentPosition});

  final controller = Get.put(MenuTabController());
  final int parentPosition;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          MenuItemInfo info =
              controller.menuItemsList[parentPosition].items![position];
          return ItemContainer(
            width: double.infinity,
            margin: EdgeInsets.only(top: 6, bottom: 6),
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                          flex: 7,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextView(
                                info.englishName,
                                color: primaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SubtitleTextView(
                                info.gujaratiName,
                                fontSize: 15,
                              )
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(left: 12, right: 14),
                        width: 0.6,
                        height: 30,
                        color: AppUtils.haxColor("#b8b8b8"),
                      ),
                      Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: TitleTextView(
                            "₹ ${info.price}",
                            color: primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [addButton(info), updateQuantityView(info)],
                  ),
                )
              ],
            ),
          );
        },
        itemCount: controller.menuItemsList[parentPosition].items!.length,
        separatorBuilder: (context, position) => Container()));
  }

  Widget addButton(MenuItemInfo info) => Visibility(
        visible: (info.quantity ?? 0) == 0,
        child: PrimaryButton(
            width: 70,
            height: 32,
            buttonText: 'add'.tr.toUpperCase(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            onPressed: () {
              controller.addToCartItemApi(
                  isProgress: true, itemId: info.id ?? 0, quantity: 1);
            }),
      );

  Widget updateQuantityView(MenuItemInfo info) => Visibility(
        visible: (info.quantity ?? 0) > 0,
        child: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  int updateQty = (info.quantity ?? 0) - 1;
                  controller.updateCartItemApi(
                      isProgress: true,
                      cartId: info.cartId ?? 0,
                      itemId: info.id ?? 0,
                      quantity: updateQty);
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Icon(
                    Icons.remove,
                    color: Colors.grey,
                    size: 22,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 40,
                child: TitleTextView(
                  (info.quantity ?? 0).toString(),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  int updateQty = (info.quantity ?? 0) + 1;
                  controller.updateCartItemApi(
                      isProgress: true,
                      cartId: info.cartId ?? 0,
                      itemId: info.id ?? 0,
                      quantity: updateQty);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
