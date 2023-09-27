class LoungeHistoryDetailModel {
  String? id;
  String? name;
  String? email;
  String? contact;
  String? companyName;
  String? reservationDate;
  String? startTime;
  String? endTime;
  String? displayStatus;
  String? status;
  String? canCancel;
  String? canCancelButtonEnabled;
  String? usageHours;
  String? purpose;
  String? displayNumberOfParticipants;
  String? displayPaymentMethod;
  String? equipments;
  String? canEdit;
  bool? success;

  LoungeHistoryDetailModel(
      {this.id,
      this.name,
      this.email,
      this.contact,
      this.companyName,
      this.reservationDate,
      this.startTime,
      this.endTime,
      this.displayStatus,
      this.status,
      this.canCancel,
      this.usageHours,
      this.canCancelButtonEnabled,
      this.purpose,
      this.displayNumberOfParticipants,
      this.displayPaymentMethod,
      this.equipments,
      this.canEdit,
      this.success});

  LoungeHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    companyName = json['company_name'];
    reservationDate = json['reservation_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    displayStatus = json['display_status'];
    status = json['status'];
    canCancel = json['can_cancel'];
    usageHours = json['usage_hours'];
    success = json['success'];
    canCancelButtonEnabled = json['can_cancel_button_enabled'];
    purpose = json['purpose'];
    displayNumberOfParticipants = json['no_of_participants'];
    displayPaymentMethod = json['display_payment_method'];
    equipments = json['equipments'];
    canEdit = json['can_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['contact'] = contact;
    data['company_name'] = companyName;
    data['reservation_date'] = reservationDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['display_status'] = displayStatus;
    data['status'] = status;
    data['can_cancel'] = canCancel;
    data['usage_hours'] = usageHours;
    data['success'] = success;
    data['can_cancel_button_enabled'] = canCancelButtonEnabled;
    data['purpose'] = purpose;
    data['no_of_participants'] = displayNumberOfParticipants;
    data['display_payment_method'] = displayPaymentMethod;
    data['equipments'] = equipments;
    data['can_edit'] = canEdit;

    return data;
  }
}
