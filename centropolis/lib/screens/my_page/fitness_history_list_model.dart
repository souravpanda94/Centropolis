class FitnessHistoryListModel {
  String? id;
  String? name;
  String? username;
  String? userId;
  String? email;
  String? mobile;
  String? reservationDate;
  String? startTime;
  String? endTime;
  String? usageHours;
  String? seat;
  String? status;
  String? createdDate;

  FitnessHistoryListModel(
      {this.id,
      this.name,
      this.username,
      this.userId,
      this.email,
      this.mobile,
      this.reservationDate,
      this.startTime,
      this.endTime,
      this.usageHours,
      this.seat,
      this.status,
      this.createdDate});

  FitnessHistoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    username = json['username'];
    userId = json['user_id'].toString();
    email = json['email'];
    mobile = json['mobile'];
    reservationDate = json['reservation_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    usageHours = json['usage_hours'].toString();
    seat = json['seat'].toString();
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['user_id'] = userId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['reservation_date'] = reservationDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['usage_hours'] = usageHours;
    data['seat'] = seat;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}
