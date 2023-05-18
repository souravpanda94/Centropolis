import 'package:flutter/foundation.dart';

import '../models/gx_fitness_reservation_model.dart';


class GxFitnessReservationProvider extends ChangeNotifier {
  GxFitnessReservationModel? _item;
  List<GxFitnessReservationModel> gxFitnessReservationList = [];

  List<GxFitnessReservationModel>? get getGxFitnessReservationList {
    return gxFitnessReservationList;
  }

  void setItem(List<GxFitnessReservationModel> item) {
    gxFitnessReservationList = item;
    notifyListeners();
  }

  void addItem(List<GxFitnessReservationModel> item) {
    gxFitnessReservationList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    gxFitnessReservationList.removeAt(index);
    notifyListeners();
  }
}
