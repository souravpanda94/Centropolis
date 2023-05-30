class GXListHistoryModel {
  String? id;
  String? name;
  String? username;
  String? userId;
  String? email;
  String? mobile;
  String? programId;
  String? title;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? price;
  String? vatPrice;
  String? totalPrice;
  String? status;
  String? createdDate;

  GXListHistoryModel(
      {this.id,
      this.name,
      this.username,
      this.userId,
      this.email,
      this.mobile,
      this.programId,
      this.title,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.price,
      this.vatPrice,
      this.totalPrice,
      this.status,
      this.createdDate});

  GXListHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    username = json['username'];
    userId = json['user_id'].toString();
    email = json['email'];
    mobile = json['mobile'];
    programId = json['program_id'].toString();
    title = json['title'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'].toString();
    vatPrice = json['vat_price'].toString();
    totalPrice = json['total_price'].toString();
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['user_id'] = userId;
    data['email'] = email;
    data['mobile'] = mobile;
    data['program_id'] = programId;
    data['title'] = title;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    data['vat_price'] = vatPrice;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}
