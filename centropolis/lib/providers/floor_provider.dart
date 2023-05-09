import 'package:flutter/foundation.dart';
import '../models/company_model.dart';
import '../models/floor_model.dart';


class FloorProvider extends ChangeNotifier {
  FloorModel? _item;
  List<FloorModel> floorList = [];

  List<FloorModel>? get geFloorList {
    return floorList;
  }

  void setItem(List<FloorModel> item) {
    floorList = item;
    notifyListeners();
  }

  void addItem(List<FloorModel> item) {
    floorList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    floorList.removeAt(index);
    notifyListeners();
  }
}
