import 'package:flutter/foundation.dart';

import '../models/lounge_history_detail_model.dart';

class LoungeHistoryDetailsProvider extends ChangeNotifier {
  LoungeHistoryDetailModel? _loungeHistoryDetailModel;

  LoungeHistoryDetailModel? get getLoungeHistoryDetailModel {
    return _loungeHistoryDetailModel;
  }

  void setItem(LoungeHistoryDetailModel item) {
    _loungeHistoryDetailModel = item;
    notifyListeners();
  }
}
