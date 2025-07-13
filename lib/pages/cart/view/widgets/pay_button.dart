import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';

import '../../controller/cart_list_controller.dart';

class PayButton extends StatelessWidget {
  PayButton({super.key, this.totalToPay});

  final controller = Get.put(CartListController());
  final String? totalToPay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: PrimaryButton(
          buttonText: "Pay  ₹$totalToPay", onPressed: (){

      }),
    );
  }
}
