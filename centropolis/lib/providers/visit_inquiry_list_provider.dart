import 'package:flutter/foundation.dart';
import '../models/company_model.dart';
import '../models/visit_reservation_model.dart';


class VisitInquiryListProvider extends ChangeNotifier {
  List<VisitReservationModel> visitInquiryList = [];

  List<VisitReservationModel>? get getVisitInquiryList {
    return visitInquiryList;
  }

  void setItem(List<VisitReservationModel> item) {
    visitInquiryList = item;
    notifyListeners();
  }

  void addItem(List<VisitReservationModel> item) {
    visitInquiryList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    visitInquiryList.removeAt(index);
    notifyListeners();
  }
}
