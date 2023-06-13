import 'package:flutter/foundation.dart';
import '../models/inconvenience_list_model.dart';

class InconvenienceListProvider extends ChangeNotifier {
  List<IncovenienceListModel> inconvenienceModelList = [];

  List<IncovenienceListModel>? get getInconvenienceModelList {
    return inconvenienceModelList;
  }

  void setItem(List<IncovenienceListModel> item) {
    inconvenienceModelList = item;
    notifyListeners();
  }

  void addItem(List<IncovenienceListModel> item) {
    inconvenienceModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    inconvenienceModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    inconvenienceModelList = [];
    // notifyListeners();
  }
}
