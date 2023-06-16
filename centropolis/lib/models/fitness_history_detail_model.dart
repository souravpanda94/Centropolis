class FitnessHistoryDetailModel {
  String? reservationId;
  String? category;
  String? displayCategory;
  String? name;
  String? email;
  String? reservationDate;
  String? startTime;
  String? endTime;
  String? usageHours;
  String? seat;
  String? mobile;
  String? companyName;
  String? canCancel;
  String? status;
  String? displayStatus;
  String? canCancelButtonEnabled;

  FitnessHistoryDetailModel(
      {this.reservationId,
      this.category,
      this.displayCategory,
      this.name,
      this.email,
      this.reservationDate,
      this.startTime,
      this.endTime,
      this.usageHours,
      this.seat,
      this.mobile,
      this.companyName,
      this.canCancel,
      this.displayStatus,
      this.canCancelButtonEnabled,
      this.status});

  FitnessHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    reservationId = json['reservation_id'].toString();
    category = json['category'];
    displayCategory = json['display_category'];
    name = json['name'];
    email = json['email'];
    reservationDate = json['reservation_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    usageHours = json['usage_hours'].toString();
    seat = json['seat'].toString();
    mobile = json['mobile'];
    companyName = json['company_name'];
    canCancel = json['can_cancel'];
    status = json['status'];
    displayStatus = json['display_status'];
    canCancelButtonEnabled = json['can_cancel_button_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reservation_id'] = reservationId;
    data['category'] = category;
    data['display_category'] = displayCategory;
    data['name'] = name;
    data['email'] = email;
    data['reservation_date'] = reservationDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['usage_hours'] = usageHours;
    data['seat'] = seat;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['can_cancel'] = canCancel;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['can_cancel_button_enabled'] = canCancelButtonEnabled;

    return data;
  }
}
