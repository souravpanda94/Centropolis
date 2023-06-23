class LightOutDetailModel {
  String? inquiryId;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? applicationDate;
  String? requestedFloors;
  String? startTime;
  String? endTime;
  String? detail;
  String? status;
  String? displayStatus;
  bool? success;

  LightOutDetailModel(
      {this.inquiryId,
      this.name,
      this.companyName,
      this.email,
      this.contact,
      this.applicationDate,
      this.requestedFloors,
      this.startTime,
      this.endTime,
      this.detail,
      this.status,
      this.displayStatus,
      this.success});

  LightOutDetailModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    contact = json['contact'].toString();
    applicationDate = json['application_date'];
    requestedFloors = json['requested_floors'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    detail = json['detail'];
    status = json['status'];
    success = json['success'];
    displayStatus = json['display_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['contact'] = contact;
    data['application_date'] = applicationDate;
    data['requested_floors'] = requestedFloors;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['detail'] = detail;
    data['status'] = status;
    data['success'] = success;
    data['display_status'] = displayStatus;
    return data;
  }
}
