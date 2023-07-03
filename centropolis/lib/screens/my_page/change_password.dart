import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late String apiKey, email, language;
  late FToast fToast;
  bool isLoading = false;
  String currentPassword = "";
  String password = "";
  String verifyPassword = "";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    email = user.userData['email_key'].toString();
    apiKey = user.userData['api_key'].toString();
    language = tr("lang");
    debugPrint("email ===> $email");
    debugPrint("apiKey ===> $apiKey");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: LoadingOverlay(
          opacity: 0.5,
          color: CustomColors.textColor3,
          progressIndicator: const CircularProgressIndicator(
            color: CustomColors.blackColor,
          ),
          isLoading: isLoading,
          child: Scaffold(
            backgroundColor: CustomColors.whiteColor,
            appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                child: Container(
                  color: CustomColors.whiteColor,
                  child: CommonAppBar(tr("changePassword"), false, () {
                    onBackButtonPress(context);
                  }, () {}),
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.only(bottom: 45.0),
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("currentPassword"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SizedBox(
                    height: 46.0,
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      maxLength: 16,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr("pleaseEnterYourCurrentPassword"),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onChanged: (text) => {
                        // cleanErrorField(),
                        setState(() {
                          currentPassword = text;
                        }),
                      },
                    ),
                  ),
                ),

                //   if (currentPasswordValidation)
                // Container(
                //   margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                //   padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       currentPasswordErrorMsg,
                //       style: const TextStyle(
                //         fontSize: 11,
                //         color: CustomColors.textColor6,
                //         fontFamily: 'Regular',
                //       ),
                //       textAlign: TextAlign.left,
                //     ),
                //   ),
                // ),

                Container(
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("newPassword"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SizedBox(
                    height: 46.0,
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 16,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr("passwordHint"),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onChanged: (text) => {
                        // cleanErrorField(),
                        setState(() {
                          password = text;
                        }),
                      },
                    ),
                  ),
                ),

                // if (newPasswordValidation)
                //   Container(
                //     margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                //     padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //         newPasswordErrorMsg,
                //         style: const TextStyle(
                //           fontSize: 11,
                //           color: CustomColors.textColor6,
                //           fontFamily: 'Regular',
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //     ),
                //   ),

                Container(
                  margin:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("newPasswordConfirmation"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.textColor8,
                        fontFamily: 'Medium',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: SizedBox(
                    height: 46.0,
                    child: TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      maxLength: 16,
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: CustomColors.whiteColor,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(
                              color: CustomColors.dividerGreyColor, width: 1.0),
                        ),
                        hintText: tr("pleaseEnterYourNewPasswordOneMoreTime"),
                        hintStyle: const TextStyle(
                          color: CustomColors.textColor3,
                          fontSize: 14,
                          fontFamily: 'Regular',
                        ),
                      ),
                      style: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      onChanged: (text) => {
                        // cleanErrorField(),
                        setState(() {
                          verifyPassword = text;
                        }),
                      },
                    ),
                  ),
                ),
                yourButtonWidget()

                // if (confirmPasswordValidation)
                //   Container(
                //     margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                //     padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //         confirmPasswordErrorMsg,
                //         style: const TextStyle(
                //           fontSize: 11,
                //           color: CustomColors.textColor6,
                //           fontFamily: 'Regular',
                //         ),
                //         textAlign: TextAlign.left,
                //       ),
                //     ),
                //   ),
              ])),
            ),
          )),
    );
  }

  yourButtonWidget() {
    return Container(
      height: 46,
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 24),
      child: CommonButton(
          onCommonButtonTap: () {
            onChangeButtonClick();
          },
          buttonColor: CustomColors.buttonBackgroundColor,
          buttonName: tr("savebutton"),
          isIconVisible: false),
    );
  }

  onChangeButtonClick() async {
    hideKeyboard();

    if (currentPassword.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterYourCurrentPassword"));
    } else if (!isValidPassword(currentPassword)) {
      showErrorModal(tr("onlyValidPasswordIsAllowed"));
    } else if (password.trim().isEmpty) {
      showErrorModal(tr("pleaseEnterPassword"));
    } else if (!isValidPassword(password)) {
      showErrorModal(tr("onlyValidPasswordIsAllowed"));
    } else if (password == currentPassword) {
      showErrorModal(tr("currentPasswordValidation"));
    } else if (password != verifyPassword) {
      showErrorModal(tr("youHaveEnteredDifferentPassword"));
    } else {
      final InternetChecking internetChecking = InternetChecking();
      if (await internetChecking.isInternet()) {
        callResetPasswordApi();
      } else {
        showCustomToast(fToast, context, tr("noInternetConnection"), "");
      }
    }

    // }
  }

  void showErrorModal(String heading) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
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

  void callResetPasswordApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "email": email.trim(), //required
      "old_password": currentPassword.trim(), //required
      "password": password.trim(), //required
      "confirm_password": verifyPassword.trim(), //required
    };

    debugPrint("change password input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.changePasswordUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for change password ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showSuccessModal(responseJson['message'].toString(), "");
          }
          Navigator.pop(context);
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

  void showSuccessModal(String heading, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }
}
