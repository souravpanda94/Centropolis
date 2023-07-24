class GxFitnessReservationModel {
  String? id;
  String? title;
  String? paymentType;
  String? startDate;
  String? endDate;
  String? applicationStartDate;
  String? applicationEndDate;
  String? totalNop;
  String? appliedNop;
  List<ProgramDays>? programDays;
  String? price;
  String? vatPrice;
  String? totalPrice;
  String? status;
  String? displayStatus;
  String? createdDate;
  String? startTime;
  String? programDaysData;
  String? instructor;

  GxFitnessReservationModel(
      {this.id,
      this.title,
      this.paymentType,
      this.startDate,
      this.endDate,
      this.applicationStartDate,
      this.applicationEndDate,
      this.totalNop,
      this.appliedNop,
      this.programDays,
      this.price,
      this.vatPrice,
      this.totalPrice,
      this.status,
      this.displayStatus,
      this.createdDate,
      this.startTime,
      this.instructor,
      this.programDaysData});

  GxFitnessReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    paymentType = json['payment_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    applicationStartDate = json['application_start_date'];
    applicationEndDate = json['application_end_date'];
    totalNop = json['total_nop'].toString();
    appliedNop = json['applied_nop'].toString();
    if (json['program_days'] != null) {
      programDays = <ProgramDays>[];
      json['program_days'].forEach((v) {
        programDays!.add(ProgramDays.fromJson(v));
      });
    }
    price = json['price'].toString();
    vatPrice = json['vat_price'].toString();
    totalPrice = json['total_price'].toString();
    status = json['status'];
    displayStatus = json['display_status'];
    createdDate = json['created_date'];
    startTime = json['start_time'];
    programDaysData = json['program_days_data'];
    instructor = json['instructor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['payment_type'] = paymentType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['application_start_date'] = applicationStartDate;
    data['application_end_date'] = applicationEndDate;
    data['total_nop'] = totalNop;
    data['applied_nop'] = appliedNop;
    if (programDays != null) {
      data['program_days'] = programDays!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['vat_price'] = vatPrice;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['display_status'] = displayStatus;
    data['created_date'] = createdDate;
    data['start_time'] = startTime;
    data['program_days_data'] = programDaysData;
    data['instructor'] = instructor;
    return data;
  }
}

class ProgramDays {
  String? value;

  ProgramDays({this.value});

  ProgramDays.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}
