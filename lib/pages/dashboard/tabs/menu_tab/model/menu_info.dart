import 'package:tulsi_hotel/pages/dashboard/tabs/menu_tab/model/menu_item_info.dart';

class MenuInfo {
  int? id;
  String? englishName;
  String? gujaratiName;
  List<MenuItemInfo>? items;
  bool? isExpanded;

  MenuInfo(
      {this.id,
      this.englishName,
      this.gujaratiName,
      this.items,
      this.isExpanded});

  MenuInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    englishName = json['english_name'];
    gujaratiName = json['gujarati_name'];
    if (json['items'] != null) {
      items = <MenuItemInfo>[];
      json['items'].forEach((v) {
        items!.add(new MenuItemInfo.fromJson(v));
      });
    }
    isExpanded = json['isExpanded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['english_name'] = this.englishName;
    data['gujarati_name'] = this.gujaratiName;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['isExpanded'] = this.isExpanded;
    return data;
  }
}
