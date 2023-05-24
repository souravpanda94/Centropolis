
class CompanyModel {
  List<CompanyList>? companyList;
  bool? success;

  CompanyModel({this.companyList, this.success});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['company_list'] != null) {
      companyList = <CompanyList>[];
      json['company_list'].forEach((v) {
        companyList!.add(CompanyList.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (companyList != null) {
      data['company_list'] = companyList!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class CompanyList {
  int? companyId;
  String? companyName;
  String? status;

  CompanyList({this.companyId, this.companyName, this.status});

  CompanyList.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['status'] = status;
    return data;
  }
}