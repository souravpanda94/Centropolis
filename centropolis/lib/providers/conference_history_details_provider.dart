import 'package:flutter/foundation.dart';

import '../models/conference_history_detail_model.dart';

class ConferenceHistoryDetailsProvider extends ChangeNotifier {
  ConferenceHistoryDetailModel? _conferenceHistoryDetailModel;

  ConferenceHistoryDetailModel? get getConferenceHistoryDetailModel {
    return _conferenceHistoryDetailModel;
  }

  void setItem(ConferenceHistoryDetailModel item) {
    _conferenceHistoryDetailModel = item;
    notifyListeners();
  }
}
