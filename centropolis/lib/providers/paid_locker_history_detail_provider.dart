import 'package:flutter/foundation.dart';

import '../models/paid_locker_history_detail_model.dart';

class PaidLockerHistoryDetailsProvider extends ChangeNotifier {
  PaidLockerHistoryDetailModel? _paidLockerHistoryDetailModel;

  PaidLockerHistoryDetailModel? get getPaidLockerHistoryDetailModel {
    return _paidLockerHistoryDetailModel;
  }

  void setItem(PaidLockerHistoryDetailModel item) {
    _paidLockerHistoryDetailModel = item;
    notifyListeners();
  }
}
