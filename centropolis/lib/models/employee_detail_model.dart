class EmployeeDetailModel {
  String? userId;
  String? username;
  String? companyName;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? displayGender;
  String? accountType;
  String? displayAccountType;
  String? status;
  String? displayStatus;
  String? registrationDate;
  bool? success;

  EmployeeDetailModel(
      {this.userId,
      this.username,
      this.companyName,
      this.name,
      this.email,
      this.mobile,
      this.gender,
      this.displayGender,
      this.accountType,
      this.displayAccountType,
      this.status,
      this.displayStatus,
      this.registrationDate,
      this.success});

  EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    username = json['username'];
    companyName = json['company_name'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    displayGender = json['display_gender'];
    accountType = json['account_type'];
    displayAccountType = json['display_account_type'];
    status = json['status'];
    displayStatus = json['display_status'];
    registrationDate = json['registration_date'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['company_name'] = companyName;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['display_gender'] = displayGender;
    data['account_type'] = accountType;
    data['display_account_type'] = displayAccountType;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['registration_date'] = registrationDate;
    data['success'] = success;
    return data;
  }
}
