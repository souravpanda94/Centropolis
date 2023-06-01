class PaidLockerHistoryListModel {
  String? id;
  String? name;
  String? userId;
  String? email;
  String? mobile;
  String? startDate;
  String? endDate;
  String? usedMonths;
  String? lockerCode;
  String? taxPrice;
  String? payablePrice;
  String? status;
  String? createdDate;

  PaidLockerHistoryListModel(
      {this.id,
      this.name,
      this.userId,
      this.email,
      this.mobile,
      this.startDate,
      this.endDate,
      this.usedMonths,
      this.lockerCode,
      this.taxPrice,
      this.payablePrice,
      this.status,
      this.createdDate});

  PaidLockerHistoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    userId = json['user_id'].toString();
    email = json['email'];
    mobile = json['mobile'].toString();
    startDate = json['start_date'];
    endDate = json['end_date'];
    usedMonths = json['used_months'].toString();
    lockerCode = json['locker_code'].toString();
    taxPrice = json['tax_price'].toString();
    payablePrice = json['payable_price'].toString();
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['used_months'] = usedMonths;
    data['locker_code'] = lockerCode;
    data['tax_price'] = taxPrice;
    data['payable_price'] = payablePrice;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}
