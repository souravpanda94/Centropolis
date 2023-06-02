import 'package:flutter/foundation.dart';
import '../models/company_model.dart';
import '../models/visit_reservation_model.dart';


class VisitReservationListProvider extends ChangeNotifier {
  List<VisitReservationModel> visitReservationList = [];

  List<VisitReservationModel>? get getVisitReservationList {
    return visitReservationList;
  }

  void setItem(List<VisitReservationModel> item) {
    visitReservationList = item;
    notifyListeners();
  }

  void addItem(List<VisitReservationModel> item) {
    visitReservationList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    visitReservationList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    visitReservationList = [];
    // notifyListeners();
  }

}
