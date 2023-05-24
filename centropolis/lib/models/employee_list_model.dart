class EmployeeListModel {
  String? userId;
  String? name;
  String? username;
  String? mobile;
  String? email;
  String? status;
  String? displayStatus;
  String? accountType;
  String? displayAccountType;
  String? registrationDate;
  String? companyId;

  EmployeeListModel(
      {this.userId,
      this.name,
      this.username,
      this.mobile,
      this.email,
      this.status,
      this.displayStatus,
      this.accountType,
      this.displayAccountType,
      this.registrationDate,
      this.companyId});

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    name = json['name'];
    username = json['username'];
    mobile = json['mobile'];
    email = json['email'];
    status = json['status'];
    displayStatus = json['display_status'];
    accountType = json['account_type'];
    displayAccountType = json['display_account_type'];
    registrationDate = json['registration_date'];
    companyId = json['company_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['username'] = username;
    data['mobile'] = mobile;
    data['email'] = email;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['account_type'] = accountType;
    data['display_account_type'] = displayAccountType;
    data['registration_date'] = registrationDate;
    data['company_id'] = companyId;
    return data;
  }
}
