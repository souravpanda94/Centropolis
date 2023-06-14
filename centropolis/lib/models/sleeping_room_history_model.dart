class SleepingRoomHistoryModel {
  String? reservationDate;
  String? usageTime;
  String? usageHours;
  String? status;
  String? requestDate;
  String? reservationId;
  String? userId;
  String? username;
  String? name;
  String? email;
  String? mobile;
  String? displayStatus;

  SleepingRoomHistoryModel({
    this.reservationDate,
    this.usageTime,
    this.usageHours,
    this.status,
    this.requestDate,
    this.reservationId,
    this.userId,
    this.username,
    this.name,
    this.email,
    this.mobile,
    this.displayStatus,
  });

  SleepingRoomHistoryModel.fromJson(Map<String, dynamic> json) {
    reservationDate = json['reservation_date'].toString();
    usageTime = json['usage_time'].toString();
    usageHours = json['usage_hours'].toString();
    status = json['status'].toString();
    requestDate = json['request_date'].toString();
    reservationId = json['reservation_id'].toString();
    userId = json['user_id'].toString();
    username = json['username']..toString();
    name = json['name'].toString();
    email = json['email'].toString();
    mobile = json['mobile'].toString();
    displayStatus = json['display_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reservation_date'] = reservationDate;
    data['usage_time'] = usageTime;
    data['usage_hours'] = usageHours;
    data['status'] = status;
    data['request_date'] = requestDate;
    data['reservation_id'] = reservationId;
    data['user_id'] = userId;
    data['username'] = username;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['display_status'] = displayStatus;
    return data;
  }
}
