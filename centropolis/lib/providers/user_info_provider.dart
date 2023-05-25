import 'package:flutter/foundation.dart';
import '../models/conference_history_detail_model.dart';
import '../models/user_info_model.dart';


class UserInfoProvider extends ChangeNotifier {
  UserInfoModel? userInfoModel;

  UserInfoModel? get getUserInformation {
    return userInfoModel;
  }

  void setItem(UserInfoModel item) {
    userInfoModel = item;
    notifyListeners();
  }
}