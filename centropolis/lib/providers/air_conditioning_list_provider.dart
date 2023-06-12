import 'package:flutter/foundation.dart';
import '../models/air_conditioning_list_model.dart';

class AirConditioningListProvider extends ChangeNotifier {
  List<AirConditioningListModel> airConditioningModelList = [];

  List<AirConditioningListModel>? get getairConditioningModelList {
    return airConditioningModelList;
  }

  void setItem(List<AirConditioningListModel> item) {
    airConditioningModelList = item;
    notifyListeners();
  }

  void addItem(List<AirConditioningListModel> item) {
    airConditioningModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    airConditioningModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    airConditioningModelList = [];
    // notifyListeners();
  }
}
