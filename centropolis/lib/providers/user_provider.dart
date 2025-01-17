import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map userData = {};
  bool _noticeCloseStatus = false;

  UserProvider() {
    initUserProvider();
  }

  bool? get getNoticeCloseStatsus {
    return _noticeCloseStatus;
  }

  void initUserProvider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userData = (prefs.get('userData').toString());
    userData = _userData != "null" ? json.decode(_userData) as Map : {};
    // final streamSocketService = StreamSocketService();
    // streamSocketService.connectAndListen(userData['api_key'].toString());
    notifyListeners();
  }

  void doAddUser(response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = response;
    await prefs.setString('userData', json.encode(userData));
    notifyListeners();
  }

  void doUpdateUser(response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData['auth']['user'] = response;
    await prefs.setString('userData', json.encode(userData));
    notifyListeners();
  }

  void doRemoveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData = {};
    await prefs.remove('userData');
    notifyListeners();
  }

  void noticeCloseStatus(bool status) {
    _noticeCloseStatus = status;
    notifyListeners();
  }
}
