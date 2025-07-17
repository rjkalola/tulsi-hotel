import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tulsi_hotel/pages/authentication/login/view/widgets/horizontal_dotted_line.dart';
import 'package:tulsi_hotel/pages/product_list/controller/product_list_controller.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_category_info.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_info.dart';
import 'package:tulsi_hotel/pages/product_list/model/product_sub_category_info.dart';
import 'package:tulsi_hotel/res/colors.dart';
import 'package:tulsi_hotel/res/drawable.dart';
import 'package:tulsi_hotel/utils/app_utils.dart';
import 'package:tulsi_hotel/utils/image_utils.dart';
import 'package:tulsi_hotel/widgets/buttons/PrimaryButton.dart';
import 'package:tulsi_hotel/widgets/checkbox/custom_checkbox.dart';
import 'package:tulsi_hotel/widgets/container/ItemContainer.dart';
import 'package:tulsi_hotel/widgets/text/PrimaryTextViewInter.dart';
import 'package:tulsi_hotel/widgets/text/SubTitleTextView.dart';
import 'package:tulsi_hotel/widgets/text/TitleTextView.dart';

class ProductList extends StatelessWidget {
  final controller = Get.put(ProductListController());

  ProductList({super.key, required this.productList, required this.isLoading});

  final RxList<ProductInfo> productList;
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          // if (isLoading.value) {
          //   return Center(child: CircularProgressIndicator());
          // }
          //
          // if (productList.isEmpty) {
          //   return Center(child: PrimaryTextViewInter('no_data_found'.tr));
          // }

          ProductInfo info = productList[position];

          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PrimaryTextViewInter(
                      "${info.englishName} (${info.gujaratiName}) - ${info.price}",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: defaultAccentColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    ImageUtils.setSvgAssetsImage(
                        path: Drawable.subDirectoryArrowRight,
                        width: 10,
                        height: 10)
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                getCategoryList(position),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
        itemCount: productList.length,
        separatorBuilder: (context, position) => Container()));
  }

  Widget getCategoryList(int productPosition) {
    List<ProductCategoryInfo> categoryList =
        productList[productPosition].items!;
    bool isEnableOrderButton = isOrderButtonEnable(categoryList);
    return ItemContainer(
      padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        children: [
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final category = categoryList[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        PrimaryTextViewInter(
                          "${category.categoryEnglishName} (${category.categoryGujaratiName})",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Visibility(
                          visible: category.isSelection == 1,
                          child: PrimaryTextViewInter(
                            "(${'any'.tr} ${category.selectionQty})",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    getSubCategoryList(productPosition, index)
                  ],
                );
              },
              itemCount: categoryList.length,
              separatorBuilder: (context, position) => Padding(
                    padding: const EdgeInsets.only(top: 11, bottom: 16),
                    child: HorizontalDottedLine(),
                  )),
          SizedBox(
            height: 8,
          ),
          PrimaryButton(
              height: 40,
              buttonText:
                  "${'order_now'.tr} - ₹ ${productList[productPosition].price}",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isEnableOrderButton
                  ? defaultAccentColor
                  : defaultAccentLightColor,
              onPressed: () {
                if (isEnableOrderButton) {
                  // controller.resetCheckedItems(productPosition);
                  controller.storeProductApi(
                      productList[productPosition], productPosition);
                } else {
                  AppUtils.showToastMessage('please_select_all_items'.tr);
                }
              })
        ],
      ),
    );
  }

  Widget getSubCategoryList(int productPosition, int categoryPosition) {
    List<ProductSubCategoryInfo> subCategoryList =
        productList[productPosition].items![categoryPosition].details!;
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final subCategory = subCategoryList[index];
          bool isEnableCheckbox = isEnableCheckBox(
              subCategoryList,
              productList[productPosition]
                      .items![categoryPosition]
                      .selectionQty ??
                  0,
              subCategory.isCheck ?? false);
          return Obx(
            () => Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextView(
                        subCategory.englishName,
                        color: primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SubtitleTextView(
                        subCategory.gujaratiName,
                        fontSize: 14,
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: productList[productPosition]
                          .items![categoryPosition]
                          .isSelection ==
                      1,
                  child: CustomCheckbox(
                      onValueChange: isEnableCheckbox
                          ? (value) {
                              productList[productPosition]
                                  .items![categoryPosition]
                                  .details![index]
                                  .isCheck = !(productList[productPosition]
                                      .items![categoryPosition]
                                      .details![index]
                                      .isCheck ??
                                  false);
                              productList.refresh();
                            }
                          : null,
                      mValue: productList[productPosition]
                              .items![categoryPosition]
                              .details![index]
                              .isCheck ??
                          false),
                )
              ],
            ),
          );
        },
        itemCount: subCategoryList.length,
        separatorBuilder: (context, position) => Container(
              height: 6,
            ));
  }

  bool isEnableCheckBox(
      List<ProductSubCategoryInfo> list, int max, bool isCheck) {
    bool value = true;
    int count = 0;
    for (var info in list) {
      if (info.isCheck ?? false) {
        count = count + 1;
      }
    }
    value = count >= max && !isCheck;
    return !value;
  }

  bool isOrderButtonEnable(List<ProductCategoryInfo> list) {
    bool value = true;
    print("isOrderButtonEnable");
    for (var info in list) {
      if (info.isSelection == 1) {
        int count = 0;
        for (var subInfo in info.details!) {
          if (subInfo.isCheck ?? false) {
            count = count + 1;
          }
        }
        print("count:" + count.toString());
        print("info.selectionQty:" + info.selectionQty.toString());
        if (info.selectionQty != count) {
          value = false;
          break;
        }
      }
    }
    return value;
  }
}
