class IncovenienceListModel {
  String? inquiryId;
  String? title;
  String? type;
  String? status;
  String? registeredDate;
  String? displayStatus;

  IncovenienceListModel({
    this.inquiryId,
    this.title,
    this.type,
    this.status,
    this.registeredDate,
    this.displayStatus,
  });

  IncovenienceListModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    title = json['title'];
    type = json['type'];
    status = json['status'];
    registeredDate = json['registered_date'];
    displayStatus = json['display_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    data['registered_date'] = registeredDate;
    data['display_status'] = displayStatus;
    return data;
  }
}
