import 'package:flutter/foundation.dart';

import '../models/fitness_history_list_model.dart';

class FitnessHistoryListProvider extends ChangeNotifier {
  List<FitnessHistoryListModel> fitnessHistoryList = [];

  List<FitnessHistoryListModel>? get getFitnessHistoryList {
    return fitnessHistoryList;
  }

  void setItem(List<FitnessHistoryListModel> item) {
    fitnessHistoryList = item;
    notifyListeners();
  }

  void addItem(List<FitnessHistoryListModel> item) {
    fitnessHistoryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    fitnessHistoryList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    fitnessHistoryList = [];
    // notifyListeners();
  }
}
