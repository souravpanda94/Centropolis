import 'dart:io';
import 'package:centropolis/utils/utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'constants.dart';
import 'custom_urls.dart';

getDeviceIdAndDeviceType() async {
  String deviceType = '';
  String deviceId = '';
  String uniqueDeviceId = '';
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceId = iosDeviceInfo.identifierForVendor.toString();
    uniqueDeviceId =
        '${iosDeviceInfo.name} : ${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    deviceType = "iOS";
    return deviceType;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    // deviceId = androidDeviceInfo.androidId.toString();// unique ID on Android
    deviceId = androidDeviceInfo.id.toString();
    uniqueDeviceId =
        '${androidDeviceInfo.device} : ${androidDeviceInfo.id}'; // unique ID on Android

    deviceType = "android";
    return deviceType;
  }
}

getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  return version;
}

String getCurrentTime() {
  DateTime now = DateTime.now();
  String dateAndTime =
      "${now.hour}:${now.minute}:${now.second}:${now.millisecond}";
  if (kDebugMode) {
    print('timestamp===> $dateAndTime');
  }
  return dateAndTime;
}




void setFirebaseAnalyticsForBackground() async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String userType = await getDataFromSharedPreference(ConstantsData.userType);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();

  String appOpenTime =
      await getDataFromSharedPreference(ConstantsData.appOpenTime);
  debugPrint("Current open time 333333333333333 ==>  $appOpenTime");
  String appCloseTime = getCurrentTime();
  debugPrint("Current close time 333333333333333 ==>  $appCloseTime");
  String appOpenTimeStamp =
      await getDataFromSharedPreference(ConstantsData.appOpenTimeStamp);
  String appCloseTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();

  await FirebaseAnalytics.instance.logEvent(
    name: "centropolis_app_opened",
    parameters: {
      // "app_open_time": appOpenTime,
      // "app_close_time": appCloseTime,
      // "app_open_time_stamp": appOpenTimeStamp,
      // "app_close_time_stamp": appCloseTimeStamp,

      "user_id": userId,
      "company_id": companyId,
      "platform": platform,
      "app_version": appVersion,
      "server_type": FirebaseAnalyticsServerType.serverType,
      "user_type": userType,
    },
  );
}

void setFirebaseEvents({eventName}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
        },
      );
      if (kDebugMode) {
        print("FirebaseAnalytics event name ===> $eventName");
      }
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForPushNotificationSetup({status}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_push_notification_on_off",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "on_off_status": status
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForLanguageChange({language}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_change_language",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "language": language
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForVisitReservation({eventName,visitReservationId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "visit_reservation_id": visitReservationId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForChangeStatusForVisitReservation({visitReservationId, status}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_approve_reject_reservation",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "visit_reservation_id": visitReservationId,
          "status" : status
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForAddDeleteEmployee({eventName,memberId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "member_id" : memberId
        },
      );

    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForUpdateEmployee({memberId, accountStatus,accountType}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_update_employee_account",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "member_id" : memberId,
          "account_status" : accountStatus,
          "account_type": accountType
        },
      );

    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForLoungeReservation({eventName,loungeId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "lounge_id": loungeId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForConferenceReservation({eventName,conferenceId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "conference_id": conferenceId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForPaidPtReservation({eventName,paidPtId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "paid_pt_id": paidPtId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForPaidLockerReservation({eventName,paidLockerId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "paid_locker_id": paidLockerId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}







void setFirebaseEventForGXReservation({gxId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_make_gx_reservation",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "gx_id": gxId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}



void setFirebaseEventForFitnessReservation({fitnessId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_make_fitness_reservation",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "fitness_id": fitnessId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForSleepingRoomReservation({sleepingRoomId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_make_sleeping_room_reservation",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "sleeping_room_id": sleepingRoomId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForInconvenienceApply({eventName,inconvenienceId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: eventName,
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "complaint_id": inconvenienceId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForInconvenienceRating({inconvenienceId,rating}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "cp_inconvenience_details_rating",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "complaint_id": inconvenienceId,
          "rating": rating
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForAcExtension({acExtensionId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: " cp_apply_ac_extension",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "ac_inquiry_id": acExtensionId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForLightOutExtension({lightOutId}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: " cp_apply_light_out_extension",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "light_out_inquiry_id": lightOutId
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForLightOutExtensionApproveReject({lightOutId,status}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: " cp_voc_reservation_light_out_extension_approve_reject",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "light_out_extension_id": lightOutId,
          "status":status
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}

void setFirebaseEventForAcExtensionApproveReject({acExtensionId,status}) async {
  String userId = await getDataFromSharedPreference(ConstantsData.userId);
  String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

  if (ConstantsData.isFirebaseEventsFired == "true") {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: " cp_voc_reservation_ac_extension_approve_reject",
        parameters: {
          "user_id": userId,
          "company_id": companyId,
          "platform": platform,
          "app_version": appVersion,
          "server_type": FirebaseAnalyticsServerType.serverType,
          "user_type": userType,
          "ac_extension_id": acExtensionId,
          "status":status
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("FirebaseAnalytics error ===> $error");
      }
    }
  }
}


