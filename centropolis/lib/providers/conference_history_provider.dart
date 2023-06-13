import 'package:flutter/foundation.dart';
import '../models/amenity_history_model.dart';

class ConferenceHistoryProvider extends ChangeNotifier {
  AmenityHistoryModel? _item;
  List<AmenityHistoryModel> conferenceHistoryModelList = [];

  List<AmenityHistoryModel>? get getConferenceHistoryModelList {
    return conferenceHistoryModelList;
  }

  void setItem(List<AmenityHistoryModel> item) {
    conferenceHistoryModelList = item;
    notifyListeners();
  }

  void addItem(List<AmenityHistoryModel> item) {
    conferenceHistoryModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    conferenceHistoryModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    conferenceHistoryModelList = [];
    // notifyListeners();
  }
}
