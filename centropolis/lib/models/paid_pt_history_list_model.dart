class PaidPtHistoryListModel {
  String? id;
  String? name;
  String? username;
  String? userId;
  String? email;
  String? mobile;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? usageCount;
  String? totalCount;
  String? status;
  String? createdDate;

  PaidPtHistoryListModel(
      {this.id,
      this.name,
      this.username,
      this.userId,
      this.email,
      this.mobile,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.usageCount,
      this.totalCount,
      this.status,
      this.createdDate});

  PaidPtHistoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    username = json['username'];
    userId = json['user_id'].toString();
    email = json['email'];
    mobile = json['mobile'].toString();
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    usageCount = json['usage_count'].toString();
    totalCount = json['total_count'].toString();
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
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['usage_count'] = usageCount;
    data['total_count'] = totalCount;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}
