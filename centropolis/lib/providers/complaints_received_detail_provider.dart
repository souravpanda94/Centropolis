import 'package:flutter/foundation.dart';

import '../models/complaints_received_detail_model.dart';

class ComplaintsReceivedDetailsProvider extends ChangeNotifier {
  ComplaintsReceivedDetailsModel? _complaintsReceivedDetailModel;

  ComplaintsReceivedDetailsModel? get getComplaintsReceivedDetailModel {
    return _complaintsReceivedDetailModel;
  }

  void setItem(ComplaintsReceivedDetailsModel item) {
    _complaintsReceivedDetailModel = item;
    notifyListeners();
  }
}
