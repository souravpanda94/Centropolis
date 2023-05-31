class AirConditioningDetailModel {
  String? inquiryId;
  String? status;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? type;
  String? requestedFloor;
  String? detail;
  String? startTime;
  String? usageHours;
  String? requestDate;
  bool? success;

  AirConditioningDetailModel(
      {this.inquiryId,
      this.status,
      this.name,
      this.companyName,
      this.email,
      this.contact,
      this.type,
      this.requestDate,
      this.requestedFloor,
      this.detail,
      this.startTime,
      this.usageHours,
      this.success});

  AirConditioningDetailModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    status = json['status'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    contact = json['contact'].toString();
    type = json['type'];
    requestedFloor = json['requested_floors'];
    detail = json['detail'];
    startTime = json['start_time'].toString();
    usageHours = json['usage_hour'].toString();
    requestDate = json['request_date'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['status'] = status;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['contact'] = contact;
    data['type'] = type;
    data['requested_floors'] = requestedFloor;
    data['detail'] = detail;
    data['start_time'] = startTime;
    data['usage_hour'] = usageHours;
    data['request_date'] = requestDate;
    data['success'] = success;
    return data;
  }
}