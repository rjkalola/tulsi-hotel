import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_controller.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_info.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/text/SubTitleTextView.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class CartList extends StatelessWidget {
  final controller = Get.put(CartListController());

  CartList({super.key, required this.cartList});

  final RxList<CartInfo> cartList;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          CartInfo info = cartList[position];
          return ((info.productId ?? 0) != 0)
              ? productItem(info, position)
              : singleItem(info, position);
        },
        itemCount: cartList.length,
        separatorBuilder: (context, position) => Container()));
  }

  Widget singleItem(CartInfo info, int index) => ItemContainer(
        width: double.infinity,
        margin: EdgeInsets.only(top: 6, bottom: 6, left: 14, right: 14),
        padding: const EdgeInsets.fromLTRB(14, 9, 14, 9),
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
                        "₹ ${info.totalAmount}",
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
                children: [addButton(info), updateQuantityView(info, index)],
              ),
            )
          ],
        ),
      );

  Widget productItem(CartInfo info, int index) => ItemContainer(
      width: double.infinity,
      margin: EdgeInsets.only(top: 6, bottom: 6, left: 14, right: 14),
      padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: TitleTextView(
              info.englishName,
              color: primaryTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: SubtitleTextView(
              info.gujaratiName,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 13,
          ),
          HorizontalDottedLine(),
          SizedBox(
            height: 11,
          ),
          ListView.builder(
            itemCount: info.items!.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                child: Row(
                  children: [
                    Text('• ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: PrimaryTextViewInter(
                        info.items?[index] ?? "",
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(
            height: 11,
          ),
          HorizontalDottedLine(),
          SizedBox(
            height: 11,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextView(
                  "₹ ${info.totalAmount}",
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  width: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      addButton(info),
                      updateQuantityView(info, index)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ));

  Widget addButton(CartInfo info) => Visibility(
        visible: (info.quantity ?? 0) == 0,
        child: PrimaryButton(
            width: 70,
            height: 32,
            buttonText: 'add'.tr.toUpperCase(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            onPressed: () {
              // controller.addToCartItemApi(
              //     isProgress: true, itemId: info.id ?? 0, quantity: 1);
            }),
      );

  Widget updateQuantityView(CartInfo info, int index) => Visibility(
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
                      cartId: info.id ?? 0,
                      quantity: updateQty,
                      index: index);
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
                    color: Colors.black,
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
                      cartId: info.id ?? 0,
                      quantity: updateQty,
                      index: index);
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
