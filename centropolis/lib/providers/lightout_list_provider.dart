import 'package:flutter/foundation.dart';
import '../models/light_out_list_model.dart';

class LightoutListProvider extends ChangeNotifier {
  List<LightOutListModel> lightoutModelList = [];

  List<LightOutListModel>? get getLightoutModelList {
    return lightoutModelList;
  }

  void setItem(List<LightOutListModel> item) {
    lightoutModelList = item;
    notifyListeners();
  }

  void addItem(List<LightOutListModel> item) {
    lightoutModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    lightoutModelList.removeAt(index);
    notifyListeners();
  }
}
