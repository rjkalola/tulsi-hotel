class UserInfo {
  int? id;
  String? email;
  String? name;
  String? phoneNumber;
  String? image;
  String? apiToken;
  int? profileCompleted;

  UserInfo(
      {this.id,
      this.email,
      this.name,
      this.phoneNumber,
      this.image,
      this.apiToken,
      this.profileCompleted});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phoneNumber = (json['phone_number'] is String)
        ? json['phone_number']
        : json['phone_number'].toString();
    image = json['image'];
    apiToken = json['api_token'];
    profileCompleted = json['profile_completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['image'] = this.image;
    data['api_token'] = this.apiToken;
    data['profile_completed'] = this.profileCompleted;
    return data;
  }
}
