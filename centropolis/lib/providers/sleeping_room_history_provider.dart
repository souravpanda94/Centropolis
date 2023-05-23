import 'package:flutter/foundation.dart';
import '../models/sleeping_room_history_model.dart';

class SleepingRoomHistoryProvider extends ChangeNotifier {
  SleepingRoomHistoryModel? _item;
  List<SleepingRoomHistoryModel> sleepingRoomHistoryModelList = [];

  List<SleepingRoomHistoryModel>? get getSleepingHistoryModelList {
    return sleepingRoomHistoryModelList;
  }

  void setItem(List<SleepingRoomHistoryModel> item) {
    sleepingRoomHistoryModelList = item;
    notifyListeners();
  }

  void addItem(List<SleepingRoomHistoryModel> item) {
    sleepingRoomHistoryModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    sleepingRoomHistoryModelList.removeAt(index);
    notifyListeners();
  }
}
