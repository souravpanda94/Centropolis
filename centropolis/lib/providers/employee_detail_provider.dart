import 'package:flutter/foundation.dart';

import '../models/employee_detail_model.dart';

class EmployeeDetailProvider extends ChangeNotifier {
  EmployeeDetailModel? _employeeDetailModel;

  EmployeeDetailModel? get getEmplloyeeDetailModel {
    return _employeeDetailModel;
  }

  void setItem(EmployeeDetailModel item) {
    _employeeDetailModel = item;
    notifyListeners();
  }
}
