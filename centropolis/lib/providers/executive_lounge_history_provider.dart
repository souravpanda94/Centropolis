import 'package:flutter/foundation.dart';
import '../models/executive_lounge_history_model.dart';


class ExecutiveLoungeHistoryProvider extends ChangeNotifier {
  ExecutiveLoungeHistoryModel? _item;
  List<ExecutiveLoungeHistoryModel> executiveLoungeHistoryModelList = [];

  List<ExecutiveLoungeHistoryModel>? get getGxFitnessReservationList {
    return executiveLoungeHistoryModelList;
  }

  void setItem(List<ExecutiveLoungeHistoryModel> item) {
    executiveLoungeHistoryModelList = item;
    notifyListeners();
  }

  void addItem(List<ExecutiveLoungeHistoryModel> item) {
    executiveLoungeHistoryModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    executiveLoungeHistoryModelList.removeAt(index);
    notifyListeners();
  }
}
