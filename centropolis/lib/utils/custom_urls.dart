
class ApiEndPoint {
  // static String baseUrl = "https://www.google.com/api/"; // Live server
  static String baseUrl = "https://www.google.com/api/"; // Test server

  static String loginUrl = "${baseUrl}v1/user/login";
  static String withdrawalUrl = "${baseUrl}v1/user/login";
  static String logoutUrl = "${baseUrl}v1/user/login";
  static String changePasswordUrl = "${baseUrl}v1/user/login";

}

class WebViewLinks {
  // static String baseUrl = "https://www.google.com"; // Live server
  static String baseUrl = "https://www.google.com"; // Test server

  // static String privacyPolicyUrl = "$baseUrl/static-page/privacy-policy.html";
  // static String termsOfUseUrl = "$baseUrl/static-page/terms-of-use.html";
  static String privacyPolicyUrl = "https://docs.flutter.dev/reference/tutorials";
  static String termsOfUseUrl = "https://docs.flutter.dev/reference/tutorials";
}