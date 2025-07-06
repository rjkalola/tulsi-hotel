import 'package:get/get.dart';
import 'package:tulsi_hotel/res/drawable.dart';

class DataUtils {
  static List<String> activeIcons = [
    Drawable.menuOrderActiveIcon,
    Drawable.menuOrderActiveIcon,
    Drawable.menuOrderActiveIcon,
    Drawable.menuOrderActiveIcon,
  ];

  static List<String> inActiveIcons = [
    Drawable.menuOrderInactiveIcon,
    Drawable.menuOrderInactiveIcon,
    Drawable.menuOrderInactiveIcon,
    Drawable.menuOrderInactiveIcon,
  ];

  static List<String> tabLabels = [
    'home'.tr,
    'menu'.tr,
    'orders'.tr,
    'profile'.tr,
  ];
}
