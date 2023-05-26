class LightOutListModel {
  String? inquiryId;
  String? requestedFloors;
  String? requestDate;
  String? startTime;
  String? endTime;
  String? status;
  String? registeredDate;
  String? description;
  String? type;
  String? displayType;

  LightOutListModel(
      {this.inquiryId,
      this.requestedFloors,
      this.requestDate,
      this.startTime,
      this.endTime,
      this.status,
      this.registeredDate,
      this.description,
      this.type,
      this.displayType});

  LightOutListModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    requestedFloors = json['requested_floors'];
    requestDate = json['request_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    registeredDate = json['registered_date'];
    description = json['description'];
    type = json['type'];
    displayType = json['display_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['requested_floors'] = requestedFloors;
    data['request_date'] = requestDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['registered_date'] = registeredDate;
    data['description'] = description;
    data['display_type'] = displayType;
    data['type'] = type;
    return data;
  }
}
