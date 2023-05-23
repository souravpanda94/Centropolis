import 'package:flutter/foundation.dart';

import '../models/sleeping_room_history_detail_model.dart';

class SleepingRoomHistoryDetailsProvider extends ChangeNotifier {
  SleepingRoomHistoryDetailModel? _sleepingRoomHistoryDetailModel;

  SleepingRoomHistoryDetailModel? get getSleepingRoomHistoryDetailModel {
    return _sleepingRoomHistoryDetailModel;
  }

  void setItem(SleepingRoomHistoryDetailModel item) {
    _sleepingRoomHistoryDetailModel = item;
    notifyListeners();
  }
}
