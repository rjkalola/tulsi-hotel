import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';

class BillSummeryDetails extends StatelessWidget {
  const BillSummeryDetails(
      {super.key,
      this.totalAmount,
      this.taxAmount,
      this.deliveryCharge,
      this.totalToPay});

  final String? totalAmount, taxAmount, deliveryCharge, totalToPay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 6, 14, 14),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PrimaryTextViewInter(
            'bill_summary'.tr,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 3,
          ),
          itemRow('item_total'.tr, totalAmount),
          itemRow('gst_and_tax_charges'.tr, taxAmount),
          itemRow('delivery_charges'.tr, deliveryCharge),
          SizedBox(
            height: 9,
          ),
          HorizontalDottedLine(),
          Padding(
            padding: const EdgeInsets.only(top: 9, bottom: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryTextViewInter(
                  'to_pay'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                PrimaryTextViewInter(
                  "₹ $totalToPay",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ),
          HorizontalDottedLine(),
        ],
      ),
    );
  }

  Widget itemRow(String title, String? price) => Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryTextViewInter(
              title,
              fontSize: 15,
            ),
            PrimaryTextViewInter(
              "₹ $price",
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      );
}
