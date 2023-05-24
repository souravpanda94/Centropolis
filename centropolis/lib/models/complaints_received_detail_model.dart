class ComplaintsReceivedDetailsModel {
  String? inquiryId;
  String? title;
  String? status;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? type;
  String? description;
  String? attachment;
  String? response;
  String? responseDate;
  String? canReply;
  String? registeredDate;
  bool? success;

  ComplaintsReceivedDetailsModel(
      {this.inquiryId,
      this.title,
      this.status,
      this.name,
      this.companyName,
      this.email,
      this.contact,
      this.type,
      this.description,
      this.attachment,
      this.response,
      this.responseDate,
      this.canReply,
      this.registeredDate,
      this.success});

  ComplaintsReceivedDetailsModel.fromJson(Map<String, dynamic> json) {
    inquiryId = json['inquiry_id'].toString();
    title = json['title'];
    status = json['status'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    contact = json['contact'].toString();
    type = json['type'];
    description = json['description'];
    attachment = json['attachment'];
    response = json['response'];
    responseDate = json['response_date'];
    canReply = json['can_reply'];
    registeredDate = json['registered_date'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inquiry_id'] = inquiryId;
    data['title'] = title;
    data['status'] = status;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['contact'] = contact;
    data['type'] = type;
    data['description'] = description;
    data['attachment'] = attachment;
    data['response'] = response;
    data['response_date'] = responseDate;
    data['can_reply'] = canReply;
    data['registered_date'] = registeredDate;
    data['success'] = success;
    return data;
  }
}
