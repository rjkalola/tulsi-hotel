import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/pages/cart/controller/cart_list_controller.dart';
import 'package:tulsi_hotel/pages/cart/model/cart_info.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/controller/order_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/order_tab/model/order_info.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/text/SubTitleTextView.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class OrderList extends StatelessWidget {
  final controller = Get.put(OrderTabController());

  OrderList({super.key, required this.orderList});

  final RxList<OrderInfo> orderList;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 14),
            child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: controller.controller,
                itemBuilder: (context, position) {
                  OrderInfo info = orderList[position];
                  return ((info.productId ?? 0) != 0)
                      ? productItem(info, position)
                      : singleItem(info, position);
                },
                itemCount: orderList.length,
                separatorBuilder: (context, position) => Container()),
          ),
        ));
  }

  Widget singleItem(OrderInfo info, int index) => ItemContainer(
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
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
              child: SubtitleTextView(
                info.address ?? "",
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 13,
            ),
            HorizontalDottedLine(),
            SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
              child: Row(
                children: [
                  Expanded(
                      child: SubtitleTextView(
                    info.orderText ?? "",
                    fontSize: 14,
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  TitleTextView(
                    "₹ ${info.totalAmount}",
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
            )
          ],
        ),
      );

  Widget productItem(OrderInfo info, int index) => ItemContainer(
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
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, top: 2),
            child: SubtitleTextView(
              info.address ?? "",
              fontSize: 13,
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
              children: [
                Expanded(
                    child: SubtitleTextView(
                  info.orderText ?? "",
                  fontSize: 14,
                )),
                SizedBox(
                  width: 12,
                ),
                TitleTextView(
                  "₹ ${info.totalAmount}",
                  color: primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          )
        ],
      ));
}
