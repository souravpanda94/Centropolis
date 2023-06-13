import 'package:flutter/foundation.dart';

import '../models/paid_pt_history_list_model.dart';

class PaidPtHistoryListProvider extends ChangeNotifier {
  List<PaidPtHistoryListModel> paidPtHistoryList = [];

  List<PaidPtHistoryListModel>? get getPaidPtHistoryList {
    return paidPtHistoryList;
  }

  void setItem(List<PaidPtHistoryListModel> item) {
    paidPtHistoryList = item;
    notifyListeners();
  }

  void addItem(List<PaidPtHistoryListModel> item) {
    paidPtHistoryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    paidPtHistoryList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    paidPtHistoryList = [];
    // notifyListeners();
  }
}
