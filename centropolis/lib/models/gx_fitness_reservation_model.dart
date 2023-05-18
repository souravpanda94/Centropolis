
class GxFitnessReservationModel {
  int? paginationLimit;
  int? totalPages;
  int? currentPage;
  int? totalRecords;
  List<ReserveGxData>? reserveGxData;
  bool? success;

  GxFitnessReservationModel(
      {this.paginationLimit,
        this.totalPages,
        this.currentPage,
        this.totalRecords,
        this.reserveGxData,
        this.success});

  GxFitnessReservationModel.fromJson(Map<String, dynamic> json) {
    paginationLimit = json['pagination_limit'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    totalRecords = json['total_records'];
    if (json['reservegx_data'] != null) {
      reserveGxData = <ReserveGxData>[];
      json['reservegx_data'].forEach((v) {
        reserveGxData!.add(ReserveGxData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pagination_limit'] = paginationLimit;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['total_records'] = totalRecords;
    if (reserveGxData != null) {
      data['reservegx_data'] =
          reserveGxData!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class ReserveGxData {
  int? id;
  String? title;
  String? paymentType;
  String? startDate;
  String? endDate;
  String? applicationStartDate;
  String? applicationEndDate;
  int? totalNop;
  int? appliedNop;
  List<ProgramDays>? programDays;
  int? price;
  int? vatPrice;
  int? totalPrice;
  String? status;
  String? displayStatus;
  String? createdDate;

  ReserveGxData(
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
        this.createdDate});

  ReserveGxData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    paymentType = json['payment_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    applicationStartDate = json['application_start_date'];
    applicationEndDate = json['application_end_date'];
    totalNop = json['total_nop'];
    appliedNop = json['applied_nop'];
    if (json['program_days'] != null) {
      programDays = <ProgramDays>[];
      json['program_days'].forEach((v) {
        programDays!.add(ProgramDays.fromJson(v));
      });
    }
    price = json['price'];
    vatPrice = json['vat_price'];
    totalPrice = json['total_price'];
    status = json['status'];
    displayStatus = json['display_status'];
    createdDate = json['created_date'];
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