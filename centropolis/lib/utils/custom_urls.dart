class ApiEndPoint {
  // static String baseUrl = "https://www.google.com/api/"; // Live server
  static String baseUrl =
      "https://centropolis-api-dev.dvconsulting.org/api/"; // Development server

  static String loginUrl = "${baseUrl}v1/login";
  static String findIdUrl = "${baseUrl}v1/find-username";
  static String findPasswordUrl = "${baseUrl}v1/find-password";
  static String signUpdUrl = "${baseUrl}v1/signup";
  static String getCompanyListUrl = "${baseUrl}v1/company-list";
  static String getFloorListUrl = "${baseUrl}v1/common/company-floor-list";
  static String verifyUserNameUrl = "${baseUrl}v1/verify-username";
  static String getPersonalInformationUrl = "${baseUrl}v1/cms/terms-list";
  static String getUsageTimeListUrl = "${baseUrl}v1/common/lounge-type";
  static String getTimeListUrl = "${baseUrl}v1/common/lounge-time-list";
  static String makeLoungeReservation =
      "${baseUrl}v1/amenity/exceutive-lounge-reservation";
  static String changePasswordUrl = "${baseUrl}v1/mypage/update-password";
  static String getConferenceTimeListUrl =
      "${baseUrl}v1/common/sleeping-room-schedule";
  static String makeConferenceReservation =
      "${baseUrl}v1/amenity/conference-reservation-inquiry";
  static String updatePersonalInfoUrl = "${baseUrl}v1/mypage/update-profile";
  static String getGxFitnessReservationUrl =
      "${baseUrl}v1/amenity/gx-program-list";
  static String getLoungeHistoryListUrl =
      "${baseUrl}v1/mypage/executive-lounge-list";
  static String getConferenceHistoryListUrl =
      "${baseUrl}v1/mypage/conference-list";

  static String getPtTimeListUrl = "${baseUrl}v1/common/pt-time";
  static String makePtReservation =
      "${baseUrl}v1/amenity/personal-training-reservation";
  static String getPaidLockerTimePeriodListUrl =
      "${baseUrl}v1/common/locker-period-list";
  static String makePaidLockerReservation =
      "${baseUrl}v1/amenity/fitness-locker-reservation";
  static String getFitnessTimeListUrl =
      "${baseUrl}v1/common/fitness-center-schedule";
  static String getFitnessTotalUsageTimeListUrl =
      "${baseUrl}v1/common/fitness-center-usage-time";
  static String makeFitnessReservation =
      "${baseUrl}v1/amenity/fitness-center-reservation";
  static String getSleepingRoomTimeListUrl =
      "${baseUrl}v1/common/sleeping-room-schedule";
  static String getSleepingRoomTotalUsageTimeListUrl =
      "${baseUrl}v1/common/sleeping-room-usage-time";
  static String makeSleepingRoomReservation =
      "${baseUrl}amenity/sleeping-room-reservation";
  static String addMemberUrl = "${baseUrl}v1/employee/save";
  static String conferenceHistoryDetailsUrl =
      "${baseUrl}v1/mypage/conference-details";
  static String cancelConferenceReservationUrl =
      "${baseUrl}v1/mypage/conference-cancel";
  static String getSleepingRoomHistoryListUrl =
      "${baseUrl}v1/mypage/sleeping-reservation-list";
  static String sleepingRoomHistoryDetailsUrl =
      "${baseUrl}v1/mypage/sleeping-reservation-details";
  static String getInconvenienceListUrl = "${baseUrl}v1/mypage/complaint-list";
  static String getLightsOutListUrl =
      "${baseUrl}v1/mypage/light-out-inquiry-list";
  static String gxReservationUrl =
      "${baseUrl}v1/amenity/gx-program-reservation";
  static String complaintsReceivedDetailsUrl =
      "${baseUrl}v1/mypage/complaint-details";
  static String registeredEmployeeListUrl = "${baseUrl}v1/employee/list";

  static String withdrawalUrl = "${baseUrl}v1";
  static String logoutUrl = "${baseUrl}v1";
}

class WebViewLinks {
  // static String baseUrl = "https://www.google.com"; // Live server
  static String baseUrl = "https://www.google.com"; // Test server

  static String privacyPolicyUrl =
      "https://docs.flutter.dev/reference/tutorials";
  static String termsOfUseUrl = "https://docs.flutter.dev/reference/tutorials";
  static String freeParkingVehicleRegistrationUrl =
      "http://centropolis.co.kr/About/parking.asp";
}
