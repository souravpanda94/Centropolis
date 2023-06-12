import 'package:flutter/foundation.dart';
import '../models/employee_list_model.dart';

class EmployeeListProvider extends ChangeNotifier {
  List<EmployeeListModel> employeeModelList = [];

  List<EmployeeListModel>? get getEmployeeModelList {
    return employeeModelList;
  }

  void setItem(List<EmployeeListModel> item) {
    employeeModelList = item;
    notifyListeners();
  }

  void addItem(List<EmployeeListModel> item) {
    employeeModelList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    employeeModelList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    employeeModelList = [];
    // notifyListeners();
  }
}
