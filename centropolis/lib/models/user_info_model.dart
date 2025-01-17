class UserInfoModel {
  int? userId;
  String? name;
  String? username;
  String? email;
  String? mobile;
  String? userType;
  String? accountType;
  int? companyId;
  String? companyName;
  String? gender;
  String? building;
  String? displayUserType;
  bool? success;
  int? unreadNotificationCount;
  String? buildingKey;

  UserInfoModel(
      {this.userId,
      this.name,
      this.username,
      this.email,
      this.mobile,
      this.userType,
      this.accountType,
      this.companyId,
      this.companyName,
      this.gender,
      this.building,
      this.displayUserType,
      this.success,
      this.unreadNotificationCount,
      this.buildingKey
      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    userType = json['user_type'];
    accountType = json['account_type'];
    companyId = json['company_id'];
    companyName = json['company_name'];
    gender = json['gender'];
    building = json['building'];
    displayUserType = json['display_user_type'];
    success = json['success'];
    unreadNotificationCount = json['unread_notification_count'];
    buildingKey=json['building_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['mobile'] = mobile;
    data['user_type'] = userType;
    data['account_type'] = accountType;
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['gender'] = gender;
    data['building'] = building;
    data['display_user_type'] = displayUserType;
    data['success'] = success;
    data['unread_notification_count'] = unreadNotificationCount;
    data['building_key']=buildingKey;
    return data;
  }
}
