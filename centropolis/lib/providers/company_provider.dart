import 'package:flutter/foundation.dart';
import '../models/company_model.dart';


class CompanyProvider extends ChangeNotifier {
  CompanyModel? _item;
  List<CompanyModel> companyList = [];

  List<CompanyModel>? get getCompanyList {
    return companyList;
  }

  void setItem(List<CompanyModel> item) {
    companyList = item;
    notifyListeners();
  }

  void addItem(List<CompanyModel> item) {
    companyList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    companyList.removeAt(index);
    notifyListeners();
  }
}
