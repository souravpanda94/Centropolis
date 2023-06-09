
class ViewSeatSelectionModel {
  int? seat;
  bool? available;
  String? slot;
  String? slotRange;

  ViewSeatSelectionModel({this.seat, this.available, this.slot,this.slotRange});

  ViewSeatSelectionModel.fromJson(Map<String, dynamic> json) {
    seat = json['seat'];
    available = json['available'];
    slot = json['slot'];
    slotRange = json['slot_range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seat'] = seat;
    data['available'] = available;
    data['slot'] = slot;
    data['slot_range'] = slotRange;
    return data;
  }
}


