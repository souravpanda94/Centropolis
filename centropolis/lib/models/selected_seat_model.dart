
class SelectedSeatModel {
  int? seat;
  bool? available;

  SelectedSeatModel({this.seat, this.available});

  SelectedSeatModel.fromJson(Map<String, dynamic> json) {
    seat = json['seat'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seat'] = seat;
    data['available'] = available;
    return data;
  }
}