
class VisitReservationModel {
  int? visitId;
  String? visitorName;
  String? companyName;
  String? visitedPersonName;
  String? visitedPersonCompanyName;
  String? visitDate;
  String? visitTime;
  String? displayStatus;
  String? status;
  String? visitPurpose;
  String? displayVisitPurpose;

  VisitReservationModel(
      {this.visitId,
        this.visitorName,
        this.companyName,
        this.visitedPersonName,
        this.visitedPersonCompanyName,
        this.visitDate,
        this.visitTime,
        this.displayStatus,
        this.status,
        this.visitPurpose,
        this.displayVisitPurpose});

  VisitReservationModel.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'];
    visitorName = json['visitor_name'];
    companyName = json['company_name'];
    visitedPersonName = json['visited_person_name'];
    visitedPersonCompanyName = json['visited_person_company_name'];
    visitDate = json['visit_date'];
    visitTime = json['visit_time'];
    displayStatus = json['display_status'];
    status = json['status'];
    visitPurpose = json['visit_purpose'];
    displayVisitPurpose = json['display_visit_purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visit_id'] = visitId;
    data['visitor_name'] = visitorName;
    data['company_name'] = companyName;
    data['visited_person_name'] = visitedPersonName;
    data['visited_person_company_name'] = visitedPersonCompanyName;
    data['visit_date'] = visitDate;
    data['visit_time'] = visitTime;
    data['display_status'] = displayStatus;
    data['status'] = status;
    data['visit_purpose'] = visitPurpose;
    data['display_visit_purpose'] = displayVisitPurpose;
    return data;
  }
}