import 'package:flutter/foundation.dart';

import '../models/air_conditioning_detail_model.dart';

class AirConditioningDetailsProvider extends ChangeNotifier {
  AirConditioningDetailModel? _airConditioningDetailModel;

  AirConditioningDetailModel? get getAirConditioningDetailModel {
    return _airConditioningDetailModel;
  }

  void setItem(AirConditioningDetailModel item) {
    _airConditioningDetailModel = item;
    notifyListeners();
  }
}
