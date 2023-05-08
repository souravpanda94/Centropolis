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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late String apiKey, userId, language;
  late FToast fToast;
  bool isLoading = false;
  String currentPassword = "";
  String password = "";
  String verifyPassword = "";
  bool currentPasswordValidation = false;
  bool newPasswordValidation = false;
  bool confirmPasswordValidation = false;
  String currentPasswordErrorMsg = "";
  String newPasswordErrorMsg = "";
  String confirmPasswordErrorMsg = "";

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    userId = user.userData['user_id'].toString();
    apiKey = user.userData['api_key'].toString();
    language = tr("lang");
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
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
                  top: 40.0,
                  left: 15.0,
                  right: 15.0,
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
                  left: 15.0,
                  right: 15.0,
                ),
                child: SizedBox(
                  height: 47.0,
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
                        borderSide: BorderSide(
                            color: currentPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: currentPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
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
                      cleanErrorField(),
                      setState(() {
                        currentPassword = text;
                      }),
                    },
                  ),
                ),
              ),
              if (currentPasswordValidation)
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      currentPasswordErrorMsg,
                      style: const TextStyle(
                        fontSize: 11,
                        color: CustomColors.textColor6,
                        fontFamily: 'Regular',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              Container(
                margin:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 28.0),
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
                  left: 15.0,
                  right: 15.0,
                ),
                child: SizedBox(
                  height: 47.0,
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
                        borderSide: BorderSide(
                            color: newPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: newPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
                      ),
                      hintText: tr("moreThan8Characters"),
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
                      cleanErrorField(),
                      setState(() {
                        password = text;
                      }),
                    },
                  ),
                ),
              ),
              if (newPasswordValidation)
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      newPasswordErrorMsg,
                      style: const TextStyle(
                        fontSize: 11,
                        color: CustomColors.textColor6,
                        fontFamily: 'Regular',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              Container(
                margin:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 28.0),
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
                  left: 15.0,
                  right: 15.0,
                ),
                child: SizedBox(
                  height: 47.0,
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
                        borderSide: BorderSide(
                            color: confirmPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                            color: confirmPasswordValidation
                                ? CustomColors.textColor6
                                : CustomColors.dividerGreyColor,
                            width: 1.0),
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
                      cleanErrorField(),
                      setState(() {
                        verifyPassword = text;
                      }),
                    },
                  ),
                ),
              ),
              if (confirmPasswordValidation)
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      confirmPasswordErrorMsg,
                      style: const TextStyle(
                        fontSize: 11,
                        color: CustomColors.textColor6,
                        fontFamily: 'Regular',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
            ])),
          ),
          floatingActionButton: yourButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }

  onChangeButtonClick() async {
    hideKeyboard();
    cleanErrorField();

    if (currentPassword == "" && password == "" && verifyPassword == "") {
      setState(() {
        currentPasswordValidation = true;
        newPasswordValidation = true;
        confirmPasswordValidation = true;
        currentPasswordErrorMsg = tr('thisIsRequiredField');
        newPasswordErrorMsg = tr('thisIsRequiredField');
        confirmPasswordErrorMsg = tr('thisIsRequiredField');
      });
    } else {
      if (!isValidPassword(currentPassword)) {
        setState(() {
          currentPasswordValidation = true;
          currentPasswordErrorMsg =
              tr('pleaseEnterYourCurrentPasswordCorrectly');
        });
      } else if (!isValidPassword(password)) {
        setState(() {
          newPasswordValidation = true;
          newPasswordErrorMsg = tr('enterPasswordAsCombination');
        });
      } else if (password == currentPassword) {
        setState(() {
          newPasswordValidation = true;
          newPasswordErrorMsg = tr("newPasswordMatchesCurrentPassword");
        });
      } else if (password != verifyPassword) {
        setState(() {
          confirmPasswordValidation = true;
          confirmPasswordErrorMsg = tr("passwordDoesNotMatch");
        });
      } else {
        final InternetChecking internetChecking = InternetChecking();
        if (await internetChecking.isInternet()) {
          // callResetPasswordApi();
        } else {
          showCustomToast(fToast, context, tr("noInternetConnection"), "");
        }
      }
    }
  }

  void callResetPasswordApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "language": language.trim(),
      "current_password": base64Enecode(currentPassword.trim()),
      "password": base64Enecode(password.trim()),
      "confirm_password": base64Enecode(verifyPassword.trim())
    };

    debugPrint("change password input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.changePasswordUrl, body, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for change password ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
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

  void cleanErrorField() {
    setState(() {
      currentPasswordValidation = false;
      newPasswordValidation = false;
      confirmPasswordValidation = false;
      currentPasswordErrorMsg = "";
      newPasswordErrorMsg = "";
      confirmPasswordErrorMsg = "";
    });
  }

  yourButtonWidget() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
          height: 52,
          width: double.infinity,
          margin: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: CommonButton(
              onCommonButtonTap: () {},
              buttonColor: CustomColors.buttonBackgroundColor,
              buttonName: tr("save"),
              isIconVisible: false),),
    );
  }
}