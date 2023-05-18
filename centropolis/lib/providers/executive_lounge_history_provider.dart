import 'package:flutter/foundation.dart';
import '../models/amenity_history_model.dart';


class ExecutiveLoungeHistoryProvider extends ChangeNotifier {
  AmenityHistoryModel? _item;
  List<AmenityHistoryModel> executiveLoungeHistoryList = [];

  List<AmenityHistoryModel>? get getExecutiveLoungeHistoryList {
    return executiveLoungeHistoryList;
  }

  void setItem(List<AmenityHistoryModel> item) {
    executiveLoungeHistoryList = item;
    notifyListeners();
  }

  void addItem(List<AmenityHistoryModel> item) {
    executiveLoungeHistoryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    executiveLoungeHistoryList.removeAt(index);
    notifyListeners();
  }
}
