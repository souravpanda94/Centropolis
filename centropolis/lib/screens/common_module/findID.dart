import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';

class FindID extends StatefulWidget {
  const FindID({super.key});

  @override
  State<FindID> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindID> {
  TextEditingController emailIDController = TextEditingController();
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
        color: CustomColors.greyColor1,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(tr("email"),
                        style: const TextStyle(
                            fontFamily: 'SemiBold',
                            fontSize: 14,
                            color: CustomColors.textColor8)),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text(" *",
                          style: TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.headingColor)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 46,
                  child: TextField(
                    inputFormatters: [RemoveEmojiInputFormatter()],
                    controller: emailIDController,
                    cursorColor: CustomColors.textColorBlack2,
                    keyboardType: TextInputType.emailAddress,
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
                      hintText: tr('emailHint'),
                      hintStyle: const TextStyle(
                        color: CustomColors.textColor3,
                        fontSize: 14,
                        height: 1.5,
                        fontFamily: 'Regular',
                      ),
                    ),
                    style: const TextStyle(
                      height: 1.5,
                      color: CustomColors.blackColor,
                      fontSize: 14,
                      fontFamily: 'Regular',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 32, bottom: 16),
                  child: CommonButton(
                      onCommonButtonTap: () {
                        // showSentUserIdModal();
                        // showSentTemporaryPasswordModal();
                        findIdValidation();
                      },
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("findID"),
                      isIconVisible: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSentUserIdModal(String title, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            // heading: tr("yourIdHasBeenSent"),
            // description: tr("sentUserIdDescription"),
            heading: title,
            description: message,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              clearDataField();
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void showEmailErrorModal(String headingMessage) {
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

  void findIdValidation() {
    if (emailIDController.text.trim().isEmpty) {
      showEmailErrorModal(tr("emailValidation"));
    } else if (!isValidEmail(emailIDController.text.trim())) {
      showEmailErrorModal(tr("onlyValidEmailIsApplicable"));
    } else {
      callFindIdNetworkCheck();
    }
  }

  void callFindIdNetworkCheck() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callFindIdApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callFindIdApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "email": emailIDController.text.trim(),
    };
    debugPrint("find id input ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.findIdUrl, body, language.trim(), null);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint("server response for find id ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          late String title, message;

          if (responseJson['title'] != null) {
            title = responseJson['title'].toString();
          }
          if (responseJson['message'] != null) {
            message = responseJson['message'].toString();
          }
          showSentUserIdModal(title, message);
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void clearDataField() {
    emailIDController.clear();
  }
}
