import 'package:flutter/foundation.dart';

import '../models/paid_pt_history_detail_model.dart';

class PaidPtHistoryDetailsProvider extends ChangeNotifier {
  PaidPtHistoryDetailModel? _paidPtDetailModel;

  PaidPtHistoryDetailModel? get getPaidPtHistoryDetailModel {
    return _paidPtDetailModel;
  }

  void setItem(PaidPtHistoryDetailModel item) {
    _paidPtDetailModel = item;
    notifyListeners();
  }
}
