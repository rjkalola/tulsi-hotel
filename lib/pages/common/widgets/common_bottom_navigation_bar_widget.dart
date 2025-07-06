import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tulsi_hotel/res/drawable.dart';

import '../../../res/colors.dart';

class CommonBottomNavigationBarWidget extends StatelessWidget {
  const CommonBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: <BottomNavigationBarItem>[
       /* BottomNavigationBarItem(
            // activeIcon: SvgPicture.asset(Drawable.activeHomeTabIcon, width: 30),
            icon: SvgPicture.asset(Drawable.inactiveHomeTabIcon, width: 30),
            label: ''),
        BottomNavigationBarItem(
            // activeIcon: SvgPicture.asset(Drawable.activeMoreTabIcon, width: 30),
            icon: SvgPicture.asset(Drawable.inactiveMoreTabIcon, width: 30),
            label: ''),*/
      ],
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: bottomTabBackgroundColor,
      onTap: onItemTapped,
    );
  }

  void onItemTapped(int index) {
    print("Index:$index");
   /* var arguments = {
      AppConstants.intentKey.dashboardTabIndex: index,
    };
    Get.offNamed(AppRoutes.dashboardScreen, arguments: arguments);*/
  }
}
