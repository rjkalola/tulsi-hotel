class DashboardResponse {
  bool? isSuccess;
  Data? data;

  DashboardResponse({this.isSuccess, this.data});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? showTodayLunch;
  int? showTodayDinner;
  int? tomorrowTodayLunch;
  int? tomorrowTodayDinner;
  int? cartCount;

  Data(
      {this.showTodayLunch,
        this.showTodayDinner,
        this.tomorrowTodayLunch,
        this.tomorrowTodayDinner,
        this.cartCount});

  Data.fromJson(Map<String, dynamic> json) {
    showTodayLunch = json['show_today_lunch'];
    showTodayDinner = json['show_today_dinner'];
    tomorrowTodayLunch = json['tomorrow_today_lunch'];
    tomorrowTodayDinner = json['tomorrow_today_dinner'];
    cartCount = json['cart_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_today_lunch'] = this.showTodayLunch;
    data['show_today_dinner'] = this.showTodayDinner;
    data['tomorrow_today_lunch'] = this.tomorrowTodayLunch;
    data['tomorrow_today_dinner'] = this.tomorrowTodayDinner;
    data['cart_count'] = this.cartCount;
    return data;
  }
}
