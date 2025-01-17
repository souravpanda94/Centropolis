class ConferenceHistoryDetailModel {
  String? conferenceId;
  String? name;
  String? companyName;
  String? email;
  String? mobile;
  String? reservationDate;
  String? usageTime;
  String? description;
  String? status;
  String? displayStatus;
  String? canCancel;
  String? canCancelButtonEnabled;
  String? packageName;
  String? packageId;

  String? conferenceRoom;
  String? equipments;
  String? canEdit;
  List<dynamic>? equipmentsValue;
  String? conferenceRoomId;
  bool? success;

  ConferenceHistoryDetailModel(
      {this.conferenceId,
      this.name,
      this.companyName,
      this.email,
      this.mobile,
      this.reservationDate,
      this.usageTime,
      this.description,
      this.status,
      this.displayStatus,
      this.canCancel,
      this.canCancelButtonEnabled,
      this.packageName,
      this.conferenceRoom,
      this.equipments,
      this.canEdit,
      this.equipmentsValue,
      this.conferenceRoomId,
      this.packageId,
      this.success});

  ConferenceHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    conferenceId = json['conference_id'].toString();
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    mobile = json['mobile'];
    reservationDate = json['reservation_date'];
    usageTime = json['usage_time'];
    description = json['description'];
    status = json['status'];
    displayStatus = json['display_status'];
    canCancel = json['can_cancel'];
    success = json['success'];
    canCancelButtonEnabled = json['can_cancel_button_enabled'];
    packageName = json['package_name'];
    conferenceRoom = json['display_desired_conference_hall_name'];
    conferenceRoomId = json['desired_conference_hall_id'];

    equipments = json['equipments'];
    canEdit = json['can_edit'];
    equipmentsValue = json['equipments_values'];
    packageId = json['package_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conference_id'] = conferenceId;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['reservation_date'] = reservationDate;
    data['usage_time'] = usageTime;
    data['description'] = description;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['can_cancel'] = canCancel;
    data['success'] = success;
    data['can_cancel_button_enabled'] = canCancelButtonEnabled;
    data['package_name'] = packageName;
    data['display_desired_conference_hall_name'] = conferenceRoom;
    data['desired_conference_hall_id'] = conferenceRoomId;

    data['equipments'] = equipments;
    data['can_edit'] = canEdit;
    data['equipments_values'] = equipmentsValue;
    data['package_id'] = packageId;

    return data;
  }
}
