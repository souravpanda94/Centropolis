class SleepingRoomHistoryDetailModel {
  String? reservationId;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? reservationDate;
  String? usageTime;
  String? totalUsageTime;
  String? canCancel;
  String? status;
  String? displayStatus;
  String? seat;
  String? canCancelButtonEnabled;
  bool? success;

  SleepingRoomHistoryDetailModel(
      {this.reservationId,
      this.name,
      this.companyName,
      this.email,
      this.contact,
      this.reservationDate,
      this.usageTime,
      this.totalUsageTime,
      this.canCancel,
      this.status,
      this.seat,
      this.displayStatus,
      this.canCancelButtonEnabled,
      this.success});

  SleepingRoomHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    reservationId = json['reservation_id'].toString();
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    contact = json['contact'].toString();
    reservationDate = json['reservation_date'];
    usageTime = json['usage_time'].toString();
    totalUsageTime = json['total_usage_time'].toString();
    canCancel = json['can_cancel'];
    status = json['status'];
    seat = json['seat'].toString();
    success = json['success'];
    displayStatus = json['display_status'];
    canCancelButtonEnabled = json['can_cancel_button_enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reservation_id'] = reservationId;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['contact'] = contact;
    data['reservation_date'] = reservationDate;
    data['usage_time'] = usageTime;
    data['total_usage_time'] = totalUsageTime;
    data['can_cancel'] = canCancel;
    data['status'] = status;
    data['seat'] = seat;
    data['success'] = success;
    data['display_status'] = displayStatus;
    data['can_cancel_button_enabled'] = canCancelButtonEnabled;

    return data;
  }
}
