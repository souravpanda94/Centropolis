import 'package:flutter/foundation.dart';

import '../models/paid_locker_history_list_model.dart';

class PaidLockerHistoryListProvider extends ChangeNotifier {
  List<PaidLockerHistoryListModel> paidLockerHistoryList = [];

  List<PaidLockerHistoryListModel>? get getPaidLockerHistoryList {
    return paidLockerHistoryList;
  }

  void setItem(List<PaidLockerHistoryListModel> item) {
    paidLockerHistoryList = item;
    notifyListeners();
  }

  void addItem(List<PaidLockerHistoryListModel> item) {
    paidLockerHistoryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    paidLockerHistoryList.removeAt(index);
    notifyListeners();
  }
}
