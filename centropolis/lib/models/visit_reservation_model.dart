
class VisitReservationModel {
  int? visitId;
  String? visitorName;
  String? companyName;
  String? visitedPersonName;
  String? tenantCompanyName;
  String? visitDate;
  String? visitTime;
  String? status;

  VisitReservationModel(
      {this.visitId,
        this.visitorName,
        this.companyName,
        this.visitedPersonName,
        this.tenantCompanyName,
        this.visitDate,
        this.visitTime,
        this.status});

  VisitReservationModel.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'];
    visitorName = json['visitor_name'];
    companyName = json['company_name'];
    visitedPersonName = json['visited_person_name'];
    tenantCompanyName = json['tenant_company_name'];
    visitDate = json['visit_date'];
    visitTime = json['visit_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visit_id'] = visitId;
    data['visitor_name'] = visitorName;
    data['company_name'] = companyName;
    data['visited_person_name'] = visitedPersonName;
    data['tenant_company_name'] = tenantCompanyName;
    data['visit_date'] = visitDate;
    data['visit_time'] = visitTime;
    data['status'] = status;
    return data;
  }
}