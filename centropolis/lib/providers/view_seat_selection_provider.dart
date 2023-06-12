import 'package:flutter/foundation.dart';

import '../models/gx_fitness_reservation_model.dart';
import '../models/view_seat_selection_model.dart';


class ViewSeatSelectionProvider extends ChangeNotifier {
  ViewSeatSelectionModel? _item;
  List<ViewSeatSelectionModel> viewSeatSelectionList = [];

  List<ViewSeatSelectionModel>? get getViewSeatSelectionList {
    return viewSeatSelectionList;
  }

  void setItem(List<ViewSeatSelectionModel> item) {
    viewSeatSelectionList = item;
    notifyListeners();
  }

  void addItem(List<ViewSeatSelectionModel> item) {
    viewSeatSelectionList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    viewSeatSelectionList.removeAt(index);
    notifyListeners();
  }
}
