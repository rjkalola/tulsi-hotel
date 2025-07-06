import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/controller/menu_tab_controller.dart';
import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/view/widgets/menu_items_list.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextView.dart';

class MenuList extends StatelessWidget {
  MenuList({super.key});

  final controller = Get.put(MenuTabController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.menuItemsList[position].isExpanded =
                        !(controller.menuItemsList[position].isExpanded ??
                            false);
                    controller.menuItemsList.refresh();
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            PrimaryTextView(
                              controller.menuItemsList[position].englishName ??
                                  "",
                              color: primaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            PrimaryTextView(
                              " (${controller.menuItemsList[position].gujaratiName ?? ""})",
                              color: secondaryTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                        !(controller.menuItemsList[position].isExpanded ??
                                false)
                            ? Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 26,
                              )
                            : Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 26,
                              )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0,
                  color: dividerColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Visibility(
                    visible: !(controller.menuItemsList[position].isExpanded ??
                        false),
                    child: MenuItemsList(parentPosition: position)),
              ],
            ),
          );
        },
        itemCount: controller.menuItemsList.length,
        // separatorBuilder: (context, position) => const Padding(
        //   padding: EdgeInsets.only(left: 100),
        //   child: Divider(
        //     height: 0,
        //     color: dividerColor,
        //     thickness: 0.8,
        //   ),
        // ),
        separatorBuilder: (context, position) => Container()));
  }
}
