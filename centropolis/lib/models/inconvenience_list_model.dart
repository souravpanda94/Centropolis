class IncovenienceListModel {
  String? inquiryId;
  String? title;
  String? type;
  String? status;
  String? registeredDate;

  IncovenienceListModel(
      {this.inquiryId,
      this.title,
      this.type,
      this.status,
      this.registeredDate});

  IncovenienceListModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    title = json['title'];
    type = json['type'];
    status = json['status'];
    registeredDate = json['registered_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    data['registered_date'] = registeredDate;
    return data;
  }
}
