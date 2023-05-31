class VisitReservationDetailModel {
  String? visitId;
  String? visitedPersonCompanyId;
  String? visitedPersonCompanyName;
  String? visitedPersonCompanyStatus;
  String? visitedPersonUserId;
  String? visitedPersonName;
  String? visitedPersonMobile;
  String? visitorName;
  String? visitorCompanyName;
  String? visitorEmail;
  String? visitorMobile;
  String? visitDate;
  String? visitTime;
  String? visitCode;
  String? visitPurpose;
  String? displayVisitPurpose;
  String? building;
  String? displayBuilding;
  String? floor;
  String? displayStatus;
  String? status;
  bool? success;

  VisitReservationDetailModel(
      {this.visitId,
      this.visitedPersonCompanyId,
      this.visitedPersonCompanyName,
      this.visitedPersonCompanyStatus,
      this.visitedPersonUserId,
      this.visitedPersonName,
      this.visitedPersonMobile,
      this.visitorName,
      this.visitorCompanyName,
      this.visitorEmail,
      this.visitorMobile,
      this.visitDate,
      this.visitTime,
      this.visitCode,
      this.visitPurpose,
      this.displayVisitPurpose,
      this.building,
      this.displayBuilding,
      this.floor,
      this.displayStatus,
      this.status,
      this.success});

  VisitReservationDetailModel.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'].toString();
    visitedPersonCompanyId = json['visited_person_company_id'].toString();
    visitedPersonCompanyName = json['visited_person_company_name'];
    visitedPersonCompanyStatus = json['visited_person_company_status'];
    visitedPersonUserId = json['visited_person_user_id'].toString();
    visitedPersonName = json['visited_person_name'];
    visitedPersonMobile = json['visited_person_mobile'];
    visitorName = json['visitor_name'];
    visitorCompanyName = json['visitor_company_name'];
    visitorEmail = json['visitor_email'];
    visitorMobile = json['visitor_mobile'].toString();
    visitDate = json['visit_date'];
    visitTime = json['visit_time'];
    visitCode = json['visit_code'].toString();
    visitPurpose = json['visit_purpose'];
    displayVisitPurpose = json['display_visit_purpose'];
    building = json['building'];
    displayBuilding = json['display_building'];
    floor = json['floor'];
    displayStatus = json['display_status'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visit_id'] = visitId;
    data['visited_person_company_id'] = visitedPersonCompanyId;
    data['visited_person_company_name'] = visitedPersonCompanyName;
    data['visited_person_company_status'] = visitedPersonCompanyStatus;
    data['visited_person_user_id'] = visitedPersonUserId;
    data['visited_person_name'] = visitedPersonName;
    data['visited_person_mobile'] = visitedPersonMobile;
    data['visitor_name'] = visitorName;
    data['visitor_company_name'] = visitorCompanyName;
    data['visitor_email'] = visitorEmail;
    data['visitor_mobile'] = visitorMobile;
    data['visit_date'] = visitDate;
    data['visit_time'] = visitTime;
    data['visit_code'] = visitCode;
    data['visit_purpose'] = visitPurpose;
    data['display_visit_purpose'] = displayVisitPurpose;
    data['building'] = building;
    data['display_building'] = displayBuilding;
    data['floor'] = floor;
    data['display_status'] = displayStatus;
    data['status'] = status;
    data['success'] = success;
    return data;
  }
}
