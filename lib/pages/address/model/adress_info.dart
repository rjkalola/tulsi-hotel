class AddressInfo {
  int? id;
  String? flatNumber;
  String? apartment;
  String? area;
  int? pincode;
  double? latitude;
  double? longitude;
  int? totalDistance;
  int? isDefault;

  AddressInfo(
      {this.id,
      this.flatNumber,
      this.apartment,
      this.area,
      this.pincode,
      this.latitude,
      this.longitude,
      this.totalDistance,
      this.isDefault});

  AddressInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flatNumber = json['flat_number'];
    apartment = json['apartment'];
    area = json['area'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    totalDistance = json['total_distance'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flat_number'] = this.flatNumber;
    data['apartment'] = this.apartment;
    data['area'] = this.area;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['total_distance'] = this.totalDistance;
    data['is_default'] = this.isDefault;
    return data;
  }
}
