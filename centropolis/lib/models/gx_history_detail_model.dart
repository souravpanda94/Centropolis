class GXHistoryDetailModel {
  String? category;
  String? displayCategory;
  String? programName;
  List<DayOfWeek>? dayOfWeek;
  String? usageAmount;
  String? dateOfUse;
  String? applicationPeriod;
  String? noOfPeople;
  String? appliedNop;
  String? name;
  String? email;
  String? startTime;
  String? endTime;
  String? reservationDate;
  String? mobile;
  String? companyName;
  String? status;
  bool? success;

  GXHistoryDetailModel(
      {this.category,
      this.displayCategory,
      this.programName,
      this.dayOfWeek,
      this.usageAmount,
      this.dateOfUse,
      this.applicationPeriod,
      this.noOfPeople,
      this.appliedNop,
      this.name,
      this.email,
      this.startTime,
      this.endTime,
      this.reservationDate,
      this.mobile,
      this.companyName,
      this.status,
      this.success});

  GXHistoryDetailModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    displayCategory = json['display_category'];
    programName = json['program_name'];
    if (json['day_of_week'] != null) {
      dayOfWeek = <DayOfWeek>[];
      json['day_of_week'].forEach((v) {
        dayOfWeek?.add(DayOfWeek.fromJson(v));
      });
    }
    usageAmount = json['usage_amount'].toString();
    dateOfUse = json['date_of_use'];
    applicationPeriod = json['application_period'];
    noOfPeople = json['no_of_people'].toString();
    appliedNop = json['applied_nop'].toString();
    name = json['name'];
    email = json['email'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    reservationDate = json['reservation_date'];
    mobile = json['mobile'];
    companyName = json['company_name'];
    status = json['status'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['display_category'] = displayCategory;
    data['program_name'] = programName;
    if (dayOfWeek != null) {
      data['day_of_week'] = dayOfWeek?.map((v) => v.toJson()).toList();
    }
    data['usage_amount'] = usageAmount;
    data['date_of_use'] = dateOfUse;
    data['application_period'] = applicationPeriod;
    data['no_of_people'] = noOfPeople;
    data['applied_nop'] = appliedNop;
    data['name'] = name;
    data['email'] = email;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['reservation_date'] = reservationDate;
    data['mobile'] = mobile;
    data['company_name'] = companyName;
    data['status'] = status;
    data['success'] = success;
    return data;
  }
}

class DayOfWeek {
  String? value;

  DayOfWeek({this.value});

  DayOfWeek.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}
