import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tulsi_hotel/pages/dashboard/controller/dashboard_controller.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';

import '../../../../res/colors.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({super.key});

  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset(Drawable.menuHomeActiveIcon, width: 15),
            icon: SvgPicture.asset(Drawable.menuHomeInactiveIcon, width: 15),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset(Drawable.menuActiveIcon, width: 15),
              icon: SvgPicture.asset(Drawable.menuInactiveIcon, width: 15),
              label: 'menu'.tr),
          BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset(Drawable.menuOrderActiveIcon, width: 15),
              icon: SvgPicture.asset(Drawable.menuOrderInactiveIcon, width: 15),
              label: 'orders'.tr),
          BottomNavigationBarItem(
              activeIcon:
                  SvgPicture.asset(Drawable.menuProfileActiveIcon, width: 15),
              icon: SvgPicture.asset(Drawable.menuProfileInactiveIcon, width: 15),
              label: 'profile'.tr),
        ],
        currentIndex: dashboardController.selectedIndex.value,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: defaultAccentColor,
        unselectedItemColor: AppUtils.haxColor("#808080"),
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 14, height: 1.8),
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          textStyle: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 14, height: 1.8),
        ),
        backgroundColor: bottomTabBackgroundColor,
        onTap: dashboardController.onItemTapped,
      );
      /*return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(DataUtils.activeIcons.length, (index) {
          final isSelected = dashboardController.selectedIndex.value == index;
          return GestureDetector(
            onTap: () {
              dashboardController.selectedIndex.value = index;
              dashboardController.onItemTapped(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageUtils.setSvgAssetsImage(
                  path: isSelected
                      ? DataUtils.activeIcons[index]
                      : DataUtils.inActiveIcons[index],
                  width: 24,
                  height: 24,
                ),
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      DataUtils.tabLabels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultAccentColor,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      );*/
    });
  }

/*Widget setActiveTab() => Column(
        children: [
          ImageUtils.setSvgAssetsImage(
              path: Drawable.tab1Icon,
              width: 24,
              height: 24,
              color: defaultAccentColor),
          SizedBox(
            height: 4,
          ),
          PrimaryTextView(
            text: "Home",
            color: defaultAccentColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          )
        ],
      );*/
}
