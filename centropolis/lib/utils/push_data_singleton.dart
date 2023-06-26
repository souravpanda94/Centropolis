import 'dart:async';

class PushDataSingleton {
  static final PushDataSingleton _instance = PushDataSingleton._internal();

  factory PushDataSingleton() => _instance;

  PushDataSingleton._internal();

  Map pushData = {};

  void doAddPushData(response) async {
    pushData.addAll(response);
  }

  Future<Map> getPushData() async {
    return pushData;
  }
}
