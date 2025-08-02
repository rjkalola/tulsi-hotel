class DashboardResponse {
  bool? isSuccess;
  Data? data;
  int? appVersion;

  DashboardResponse({this.isSuccess, this.data, this.appVersion});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['app_version'] = this.appVersion;
    return data;
  }
}

class Data {
  int? showTodayLunch;
  int? showTodayDinner;
  int? tomorrowTodayLunch;
  int? tomorrowTodayDinner;
  String? address;
  int? appVersion;
  int? cartCount;

  Data(
      {this.showTodayLunch,
      this.showTodayDinner,
      this.tomorrowTodayLunch,
      this.tomorrowTodayDinner,
      this.address,
      this.appVersion,
      this.cartCount});

  Data.fromJson(Map<String, dynamic> json) {
    showTodayLunch = json['show_today_lunch'];
    showTodayDinner = json['show_today_dinner'];
    tomorrowTodayLunch = json['tomorrow_today_lunch'];
    tomorrowTodayDinner = json['tomorrow_today_dinner'];
    address = json['address'];
    appVersion = json['app_version'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_today_lunch'] = this.showTodayLunch;
    data['show_today_dinner'] = this.showTodayDinner;
    data['tomorrow_today_lunch'] = this.tomorrowTodayLunch;
    data['tomorrow_today_dinner'] = this.tomorrowTodayDinner;
    data['address'] = this.address;
    data['app_version'] = this.appVersion;
    data['cart_count'] = this.cartCount;
    return data;
  }
}
