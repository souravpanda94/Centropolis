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
  String platform = getDeviceIdAndDeviceType().toString();
  String appVersion = getAppVersion().toString();
  String userType = await getDataFromSharedPreference(ConstantsData.userType);

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

void setFirebaseEventForPushNotificationSetup({eventName, status}) async {
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
          "on_off_status": status
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

void setFirebaseEventForLanguageChange({eventName, language}) async {
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
          "language": language
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

// void setFirebaseEventsWithPostId({eventName, postId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: eventName,
//         parameters: {
//           "honeypot_user_id": userId,
//           "company_id": companyId,
//           "platform": platform,
//           "app_version":appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> $eventName");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsWithOtherUserId({eventName, postId, otherUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: eventName,
//         parameters: {
//           "honeypot_user_id": userId,
//           "company_id": companyId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//           "other_user_id": otherUserId
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> $eventName");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//

// void setFirebaseEventsForHoneySent({postId, senderId, amountOfHoney}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_honey_sent",
//         parameters: {
//           "honeypot_user_id": userId,
//           "company_id": companyId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//           "sender_id": senderId,
//           "amount_of_honey": amountOfHoney
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_honey_sent");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForPostSearched({searchType}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String companyId = await getDataFromSharedPreference(ConstantsData.companyId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_post_searched",
//         parameters: {
//           "honeypot_user_id": userId,
//           "company_id": companyId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "search_type": searchType,
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_post_searched");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }

// void setFirebaseEventsForUserBlocked({chatRoomId, blockedUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_user_blocked",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "chat_room_id": chatRoomId,
//           "blocked_user_id": blockedUserId
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_user_blocked");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForBuddyAdded({addedUserId, chatRoomId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_buddy_added",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "added_user_id": addedUserId,
//           "chat_room_id": chatRoomId
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_buddy_added");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForChatRoomLeft({chatRoomId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_chat_room_left",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "chat_room_id": chatRoomId,
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_chat_room_left");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForNotificationRead({notificationId, notificationType}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_notification_read",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "notification_id": notificationId,
//           "notification_type": notificationType
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_notification_read");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForBadgeChanged({badgeName}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_representative_badge_changed",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "badge_name": badgeName,
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_representative_badge_changed");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForInterestTagEdited({tagsId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_intersted_tags_edited",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "tags_id": tagsId,
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_intersted_tags_edited");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForUserUnblocked({unblockedUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_user_unblocked",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "unblocked_user_id": unblockedUserId
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_user_unblocked");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForNoticeDetailsViewed({noticeId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String appVersion = getAppVersion().toString();
//   String platform = getDeviceIdAndDeviceType().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_notice_detail_viewed",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "notice_id": noticeId
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_notice_detail_viewed");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForPushedNotificationPermission({actionType}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_push_notification_allow_or_deny",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "action_type": actionType
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_push_notification_allow_or_deny");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForCustomizedPostComment({postId, postedByUserId,commentedByUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//   String eventTime = getCurrentTime();
//   String eventTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_customized_post_commented",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//           "posted_by_user_id": postedByUserId,
//           "commented_by_user_id": commentedByUserId,
//           "event_time": eventTime,
//           "event_timestamp": eventTimestamp
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_customized_post_commented");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForCustomizedPostLike({postId, postedByUserId,likedByUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//   String eventTime = getCurrentTime();
//   String eventTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_customized_post_liked",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//           "posted_by_user_id": postedByUserId,
//           "liked_by_user_id": likedByUserId,
//           "event_time": eventTime,
//           "event_timestamp": eventTimestamp
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_customized_post_liked");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
//
// void setFirebaseEventsForCustomizedPostCommentReply({postId, postedByUserId,repliedByUserId}) async {
//   String userId = await getDataFromSharedPreference(ConstantsData.userId);
//   String apartmentId = await getDataFromSharedPreference(ConstantsData.apartmentId);
//   String platform = getDeviceIdAndDeviceType().toString();
//   String appVersion = getAppVersion().toString();
//   String eventTime = getCurrentTime();
//   String eventTimestamp = DateTime.now().millisecondsSinceEpoch.toString();
//
//
//   if (ConstantsData.isFirebaseEventsFired == "true") {
//     try {
//       await FirebaseAnalytics.instance.logEvent(
//         name: "hp_customized_post_comment_replied",
//         parameters: {
//           "honeypot_user_id": userId,
//           "apartment_id": apartmentId,
//           "platform": platform,
//           "app_version": appVersion,
//           "server_type": FirebaseAnalyticsServerType.serverType,
//           "post_id": postId,
//           "posted_by_user_id": postedByUserId,
//           "replied_by_user_id": repliedByUserId,
//           "event_time": eventTime,
//           "event_timestamp": eventTimestamp
//         },
//       );
//       if (kDebugMode) {
//         print("FirebaseAnalytics event name ===> hp_customized_post_comment_replied");
//       }
//     } catch (error) {
//       if (kDebugMode) {
//         print("FirebaseAnalytics error ===> $error");
//       }
//     }
//   }
// }
