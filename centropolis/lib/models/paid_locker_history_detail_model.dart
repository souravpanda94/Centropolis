class PaidLockerHistoryDetailModel {
  String? category;
  String? displayCategory;
  String? name;
  String? email;
  String? startDate;
  String? endDate;
  String? usedMonths;
  String? lockerCode;
  String? mobile;
  String? companyName;
  String? status;
  bool? success;

  PaidLockerHistoryDetailModel(
      {this.category,
      this.displayCategory,
      this.name,
      this.email,
      this.startDate,
      this.endDate,
      this.usedMonths,
      this.lockerCode,
      this.mobile,
      this.companyName,
      this.status,
      this.success});

  PaidLockerHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    displayCategory = json['display_category'];
    name = json['name'];
    email = json['email'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    usedMonths = json['used_months'].toString();
    lockerCode = json['locker_code'].toString();
    mobile = json['mobile'].toString();
    companyName = json['company_name'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['display_category'] = displayCategory;
    data['name'] = name;
    data['email'] = email;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['used_months'] = usedMonths;
    data['locker_code'] = lockerCode;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['status'] = status;
    data['success'] = success;
    return data;
  }
}
