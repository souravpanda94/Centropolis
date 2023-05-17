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

  static String withdrawalUrl = "${baseUrl}v1";
  static String logoutUrl = "${baseUrl}v1";
}

class WebViewLinks {
  // static String baseUrl = "https://www.google.com"; // Live server
  static String baseUrl = "https://www.google.com"; // Test server

  // static String privacyPolicyUrl = "$baseUrl/static-page/privacy-policy.html";
  // static String termsOfUseUrl = "$baseUrl/static-page/terms-of-use.html";
  static String privacyPolicyUrl =
      "https://docs.flutter.dev/reference/tutorials";
  static String termsOfUseUrl = "https://docs.flutter.dev/reference/tutorials";
  static String freeParkingVehicleRegistrationUrl =
      "https://docs.flutter.dev/reference/tutorials";
}
