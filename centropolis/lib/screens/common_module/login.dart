import 'dart:convert';
import 'package:centropolis/widgets/bottom_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import 'find_ID_password.dart';
import 'signup.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool checkSigned = false;
  bool isLoading = false;
  late String language;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.blackColor,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: CustomColors.whiteColor,
          appBar: AppBar(
            toolbarHeight: 54,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            elevation: 0,
            backgroundColor: CustomColors.whiteColor,
            title: Text(
              tr("login"),
              style: const TextStyle(
                color: CustomColors.textColor8,
                fontFamily: 'SemiBold',
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: Container(
            color: CustomColors.whiteColor,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/centropolis_logo.png',
                    height: 69,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextField(
                      controller: emailIDController,
                      maxLength: 16,
                      cursorColor: CustomColors.textColorBlack2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('id'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 46,
                    child: TextField(
                      controller: passwordController,
                      cursorColor: CustomColors.textColorBlack2,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr('password'),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.blackColor,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            checkColor: CustomColors.whiteColor,
                            activeColor: CustomColors.buttonBackgroundColor,
                            side: const BorderSide(
                                color: CustomColors.greyColor, width: 1),
                            value: checkSigned,
                            onChanged: (value) {
                              setState(() {
                                checkSigned = value!;
                                if (checkSigned) {
                                } else {}
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Text(
                        tr("saveLoginInformation"),
                        style: const TextStyle(
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColorBlack2),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 32, bottom: 16),
                    child: CommonButton(
                        onCommonButtonTap: () {
                          onLoginButtonClick();
                        },
                        buttonColor: CustomColors.buttonBackgroundColor,
                        buttonName: tr("btnLogin"),
                        isIconVisible: false),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FindIDPassword(page: 0),
                                ),
                              );
                            },
                            child: Text(
                              tr("findID"),
                              style: const TextStyle(
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 3),
                            child: const VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: CustomColors.borderColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FindIDPassword(page: 1),
                                ),
                              );
                            },
                            child: Text(
                              tr("passwordReset"),
                              style: const TextStyle(
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 3),
                            child: const VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: CustomColors.borderColor,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              tr("signUp"),
                              style: const TextStyle(
                                  color: CustomColors.greyColor1,
                                  fontFamily: 'Regular',
                                  fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(0, 0),
      ),
    );
  }

  void showUserIdErrorModal(String headingMessage) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: headingMessage,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void showPasswordErrorModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("pleaseEnterPassword"),
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void showCredentialErrorModal(String title) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            // heading: tr("pleaseCheckYourAccountAndTryAgain"),
            heading: title,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void showUnapprovedErrorModal(title, description) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            // heading: tr("thisIsAnUnapprovedAccount"),
            // description: tr("pleaseLogInAfterApproval"),
            heading: title,
            description: description,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void onLoginButtonClick() {
    loginValidation();
  }

  void loginValidation() async {
    hideKeyboard();

    if (emailIDController.text.trim().isEmpty) {
      showUserIdErrorModal(tr("IDHint"));
    } else if (!isValidUserId(emailIDController.text.trim())) {
      showUserIdErrorModal(tr("onlyValidEmailIsApplicable"));
    } else if (passwordController.text.trim().isEmpty) {
      showPasswordErrorModal();
    } else {
      doLogin();
    }
  }

  void doLogin() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoginApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoginApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "username": emailIDController.text.trim(),
      "password": passwordController.text.trim(),
      "is_app_login": "y"
    };
    debugPrint("login input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.loginUrl, body, language.trim(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint("server response for login ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          late String userId,
              apiKey,
              accessTokenExpiry,
              username,
              name,
              emailKey,
              mobile,
              userType,
              companyId,
              companyName,
              gender,
              pushAlarm,
              displayUserType;
          if (responseJson['access_token'] != null) {
            apiKey = responseJson['access_token'].toString();
          }
          if (responseJson['access_token_expiry'] != null) {
            accessTokenExpiry = responseJson['access_token_expiry'].toString();
          }
          if (responseJson['user_id'] != null) {
            userId = responseJson['user_id'].toString();
          }
          if (responseJson['username'] != null) {
            username = responseJson['username'].toString();
          }
          if (responseJson['name'] != null) {
            name = responseJson['name'].toString();
          }
          if (responseJson['email'] != null) {
            emailKey = responseJson['email'].toString();
          }
          if (responseJson['mobile'] != null) {
            mobile = responseJson['mobile'].toString();
          }
          if (responseJson['user_type'] != null) {
            userType = responseJson['user_type'].toString();
          }
          if (responseJson['company_id'] != null) {
            companyId = responseJson['company_id'].toString();
          }
          if (responseJson['company_name'] != null) {
            companyName = responseJson['company_name'].toString();
          }
          if (responseJson['gender'] != null) {
            gender = responseJson['gender'].toString();
          }
          if (responseJson['push_alarm'] != null) {
            pushAlarm = responseJson['push_alarm'].toString();
          }
          if (responseJson['display_user_type'] != null) {
            displayUserType = responseJson['display_user_type'].toString();
          }

          debugPrint("checkSigned ======> $checkSigned");

          Map<String, String> loginData = {
            "user_id": userId.trim(),
            "api_key": apiKey.trim(),
            "checked_signed_in": checkSigned.toString(),
            "email_key": emailKey.trim(),
            "user_name": username.trim(),
            "mobile": mobile.trim(),
            "name": name.trim(),
            "user_type": userType.trim(),
            "company_id": companyId.trim(),
            "company_name": companyName.trim(),
            "gender": gender.trim(),
            "push_notification": pushAlarm.trim(),
            "display_user_type": displayUserType.trim()
          };
          var user = Provider.of<UserProvider>(context, listen: false);
          user.doAddUser(loginData);
          goToHomeScreen();
        } else {
          if (responseJson['status_code'] == 7001) {
            showUnapprovedErrorModal(
                responseJson['title'], responseJson['message']);
          } else if (responseJson['status_code'] == 7002) {
            showCredentialErrorModal(responseJson['message']);
          } else {
            if (responseJson['message'] != null) {
              debugPrint("Server error response ${responseJson['message']}");
              showCustomToast(
                  fToast, context, responseJson['message'].toString(), "");
            }
          }
        }
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
