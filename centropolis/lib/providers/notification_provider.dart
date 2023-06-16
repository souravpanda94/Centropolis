import 'package:flutter/foundation.dart';
import '../models/notification_model.dart';


class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notificationList = [];

  List<NotificationModel>? get getNotificationList {
    return notificationList;
  }

  void setItem(List<NotificationModel> item) {
    notificationList = item;
    notifyListeners();
  }

  void addItem(List<NotificationModel> item) {
    notificationList.addAll(item);
    notifyListeners();
  }

  void removeItem(int index) {
    notificationList.removeAt(index);
    notifyListeners();
  }

  void setEmptyList() {
    notificationList = [];
    // notifyListeners();
  }
}
