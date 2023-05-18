
class ExecutiveLoungeHistoryModel {
  String? name;
  String? email;
  String? contactNo;
  String? reservationDate;
  String? usageHours;
  String? status;
  String? displayStatus;
  String? requestDate;

  ExecutiveLoungeHistoryModel(
      {this.name,
        this.email,
        this.contactNo,
        this.reservationDate,
        this.usageHours,
        this.status,
        this.displayStatus,
        this.requestDate});

  ExecutiveLoungeHistoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    contactNo = json['contact_no'];
    reservationDate = json['reservation_date'];
    usageHours = json['usage_hours'];
    status = json['status'];
    displayStatus = json['display_status'];
    requestDate = json['request_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['contact_no'] = contactNo;
    data['reservation_date'] = reservationDate;
    data['usage_hours'] = usageHours;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['request_date'] = requestDate;
    return data;
  }
}