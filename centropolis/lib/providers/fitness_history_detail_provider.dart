import 'package:flutter/foundation.dart';

import '../models/fitness_history_detail_model.dart';

class FitnessHistoryDetailsProvider extends ChangeNotifier {
  FitnessHistoryDetailModel? _fitnessLockerHistoryDetailModel;

  FitnessHistoryDetailModel? get getFitnessHistoryDetailModel {
    return _fitnessLockerHistoryDetailModel;
  }

  void setItem(FitnessHistoryDetailModel item) {
    _fitnessLockerHistoryDetailModel = item;
    notifyListeners();
  }
}
