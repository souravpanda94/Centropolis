import 'package:flutter/foundation.dart';

import '../models/gx_history_detail_model.dart';

class GXHistoryDetailsProvider extends ChangeNotifier {
  GXHistoryDetailModel? _gXHistoryDetailModel;

  GXHistoryDetailModel? get getGXHistoryDetailModel {
    return _gXHistoryDetailModel;
  }

  void setItem(GXHistoryDetailModel item) {
    _gXHistoryDetailModel = item;
    notifyListeners();
  }
}
