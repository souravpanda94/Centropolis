import 'package:flutter/foundation.dart';

import '../models/visit_reservation_detail_model.dart';

class VisitReservationDetailsProvider extends ChangeNotifier {
  VisitReservationDetailModel? _visitReservationDetailModel;

  VisitReservationDetailModel? get getVisitReservationHistoryDetailModel {
    return _visitReservationDetailModel;
  }

  void setItem(VisitReservationDetailModel item) {
    _visitReservationDetailModel = item;
    notifyListeners();
  }
}
