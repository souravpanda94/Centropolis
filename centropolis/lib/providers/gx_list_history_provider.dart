import 'package:flutter/foundation.dart';

import '../models/gx_list_history_model.dart';

class GxListHistoryProvider extends ChangeNotifier {
  List<GXListHistoryModel> gxHistoryList = [];

  List<GXListHistoryModel>? get getGxHistoryList {
    return gxHistoryList;
  }

  void setItem(List<GXListHistoryModel> item) {
    gxHistoryList = item;
    notifyListeners();
  }

  void addItem(List<GXListHistoryModel> item) {
    gxHistoryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    gxHistoryList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    gxHistoryList = [];
    // notifyListeners();
  }
}
