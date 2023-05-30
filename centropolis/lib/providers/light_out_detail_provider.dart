import 'package:flutter/foundation.dart';

import '../models/light_out_detail_model.dart';

class LightOutDetailsProvider extends ChangeNotifier {
  LightOutDetailModel? _lightOutDetailModel;

  LightOutDetailModel? get getLightOutDetailModel {
    return _lightOutDetailModel;
  }

  void setItem(LightOutDetailModel item) {
    _lightOutDetailModel = item;
    notifyListeners();
  }
}
