import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/pages/product_list/controller/product_list_controller.dart';
import 'package:tulsi_hotel/res/colors.dart';

class TabBarWidget extends StatelessWidget {
  TabBarWidget({super.key});

  final controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: TabBar(
        onTap: controller.changeTab,
        labelColor: Colors.orange,
        // selected tab text
        unselectedLabelColor: primaryTextColor,
        indicatorColor: defaultAccentColor,
        indicatorSize: TabBarIndicatorSize.tab,
        // underline color
        indicatorWeight: 2,
        labelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Tab(text: 'today'.tr),
          Tab(text: 'tomorrow'.tr),
        ],
      ),
    );
  }
}
