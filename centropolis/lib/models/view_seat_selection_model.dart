
class ViewSeatSelectionModel {
  int? seat;
  bool? available;
  String? slot;

  ViewSeatSelectionModel({this.seat, this.available, this.slot});

  ViewSeatSelectionModel.fromJson(Map<String, dynamic> json) {
    seat = json['seat'];
    available = json['available'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seat'] = seat;
    data['available'] = available;
    data['slot'] = slot;
    return data;
  }
}


