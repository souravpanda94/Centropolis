class PaidPtHistoryDetailModel {
  String? category;
  String? displayCategory;
  String? name;
  String? email;
  String? reservationStartDate;
  String? reservationEndDate;
  String? usageTime;
  String? mobile;
  String? companyName;
  String? status;
  String? displayStatus;
  String? usageCount;
  String? canEdit;

  bool? success;

  PaidPtHistoryDetailModel(
      {this.category,
      this.displayCategory,
      this.name,
      this.email,
      this.reservationStartDate,
      this.reservationEndDate,
      this.usageTime,
      this.mobile,
      this.companyName,
      this.status,
      this.displayStatus,
      this.usageCount,
      this.canEdit,
      this.success});

  PaidPtHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    displayCategory = json['display_category'];
    name = json['name'];
    email = json['email'];
    reservationStartDate = json['reservation_start_date'];
    reservationEndDate = json['reservation_end_date'];
    usageTime = json['usage_time'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    status = json['status'];
    success = json['success'];
    displayStatus = json['display_status'];
    usageCount = json['usage_count'].toString();
    canEdit = json['can_edit'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['display_category'] = displayCategory;
    data['name'] = name;
    data['email'] = email;
    data['reservation_start_date'] = reservationStartDate;
    data['reservation_end_date'] = reservationEndDate;
    data['usage_time'] = usageTime;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['status'] = status;
    data['success'] = success;
    data['display_status'] = displayStatus;
    data['usage_count'] = usageCount;
    data['can_edit'] = canEdit;

    return data;
  }
}
